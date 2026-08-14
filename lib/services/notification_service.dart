import 'dart:convert';
import 'dart:ui' show Color;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/firestore_keys.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stacked_services/stacked_services.dart';

/// Background / terminated-state FCM handler.
///
/// Must be a top-level (or static) function annotated with `vm:entry-point`
/// so the Flutter engine can locate it when the app is not running.
/// Messages sent by the Cloud Functions carry a `notification` block, so on
/// Android the OS draws the system-tray notification automatically — this
/// handler only needs to exist and keep Firebase alive for any data work.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('📩 [FCM] background message: ${message.messageId}');
}

/// Centralised Firebase Cloud Messaging service.
///
/// Responsibilities:
///  • request notification permission (Android 13+ / iOS)
///  • create the Android high-importance notification channel
///  • show foreground notifications via flutter_local_notifications
///  • keep the device FCM token synced to Firestore under
///    `users/{uid}/fcmTokens/{tokenHash}`
///  • handle taps from foreground / background / terminated launches
///
/// Registered as a LazySingleton in `app.dart`; initialised once from `main()`.
/// Actual delivery (lesson / quiz / result fan-out) is done server-side by the
/// Cloud Functions in `/functions` — the client never sends pushes itself.
class NotificationService {
  NotificationService();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// Must match `default_notification_channel_id` in AndroidManifest.xml and
  /// the `channelId` used by the Cloud Functions.
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    // Channel ID is a backend identifier — it must keep matching
    // AndroidManifest.xml and the Cloud Functions, so it is deliberately NOT
    // rebranded. Only the channel name below is shown to users (Android
    // Settings > Apps > Notifications).
    'englify_high_importance',
    'Quiznity Notifications',
    description: 'Lesson, quiz and quiz-result notifications',
    importance: Importance.high,
  );

  bool _initialized = false;
  String? _currentToken;

  /// A notification that launched the app from a terminated state. Held until
  /// [handleLaunchDeepLink] runs once the navigator is ready.
  RemoteMessage? _pendingMessage;

  /// Called once from `main()` after Firebase + the locator are ready.
  /// Never throws — notification setup must not block app start-up.
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    try {
      await _setupLocalNotifications();

      // Android 13+ shows the POST_NOTIFICATIONS dialog here; iOS shows its own.
      await _messaging.requestPermission(alert: true, badge: true, sound: true);

      // iOS foreground presentation (no-op on Android).
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // Foreground messages → draw a heads-up notification manually.
      FirebaseMessaging.onMessage.listen(_onForegroundMessage);

      // App opened from the background by tapping a notification.
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageTap);

      // App launched from a terminated state by tapping a notification.
      // The navigator isn't built yet — stash it; SplashViewModel consumes it
      // via handleLaunchDeepLink() once the user has been routed home.
      _pendingMessage = await _messaging.getInitialMessage();

      // Token rotation.
      _messaging.onTokenRefresh.listen(_onTokenRefresh);

      // Keep the token in sync with the signed-in user. authStateChanges()
      // emits the current state immediately, so this also covers cold start
      // and login/signup without extra wiring.
      //
      // Gated on the user's preference — without this check, a user who turned
      // notifications off would have their token silently re-registered on the
      // next app launch and start receiving pushes again.
      _auth.authStateChanges().listen((user) async {
        if (user == null) return;
        if (await isEnabled()) syncTokenForUser(user.uid);
      });
    } catch (e) {
      debugPrint('❌ [FCM] init failed: $e');
    }
  }

  Future<void> _setupLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('ic_notification');
    // iOS permission is requested by FirebaseMessaging, not by this plugin.
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initSettings =
        InitializationSettings(android: androidInit, iOS: iosInit);

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload == null || payload.isEmpty) return;
        try {
          _routeFromData(
            Map<String, dynamic>.from(jsonDecode(payload) as Map),
          );
        } catch (_) {}
      },
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  // ───────────────────────────── Token management ─────────────────────────────

  CollectionReference<Map<String, dynamic>> _tokenCollection(String uid) =>
      _firestore
          .collection(FirestoreKeys.users)
          .doc(uid)
          .collection(FirestoreKeys.fcmTokens);

  /// Hashes the (long) token into a stable, Firestore-safe document id.
  String _docIdFor(String token) =>
      sha256.convert(utf8.encode(token)).toString();

  /// Reads the device token and writes it to
  /// `users/{uid}/fcmTokens/{tokenHash}`. Safe to call repeatedly.
  // ─────────────────────── Enable / disable (profile toggle) ───────────────

  /// Whether the user wants push notifications on this device.
  Future<bool> isEnabled() =>
      locator<LocalStorageService>().getnotificationsenabled();

  /// Turns push on or off for real, not just in the UI.
  ///
  /// Off deletes this device's token so the backend has nothing to push to; on
  /// registers a fresh one. The preference is persisted either way so the
  /// choice survives a restart.
  Future<void> setEnabled(bool enabled) async {
    await locator<LocalStorageService>().savenotificationsenabled(enabled);

    final uid = _auth.currentUser?.uid;
    if (enabled) {
      if (uid != null) await syncTokenForUser(uid);
    } else {
      await clearTokenForCurrentUser();
    }
  }

  Future<void> syncTokenForUser(String uid) async {
    try {
      final token = await _messaging.getToken();
      if (token == null || token.isEmpty) return;
      _currentToken = token;
      await _writeToken(uid, token);
      debugPrint('✅ [FCM] token synced for $uid');
    } catch (e) {
      debugPrint('❌ [FCM] syncToken failed: $e');
    }
  }

  Future<void> _writeToken(String uid, String token) {
    return _tokenCollection(uid).doc(_docIdFor(token)).set({
      FirestoreKeys.token: token,
      FirestoreKeys.platform: defaultTargetPlatform.name,
      FirestoreKeys.updatedAt: FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> _onTokenRefresh(String newToken) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;
    try {
      // Drop the stale token document so dead tokens don't accumulate.
      final old = _currentToken;
      if (old != null && old != newToken) {
        await _tokenCollection(uid).doc(_docIdFor(old)).delete();
      }
      _currentToken = newToken;
      await _writeToken(uid, newToken);
      debugPrint('🔄 [FCM] token refreshed for $uid');
    } catch (e) {
      debugPrint('❌ [FCM] token refresh failed: $e');
    }
  }

  /// Removes this device's token for the currently signed-in user.
  ///
  /// Call this *before* `FirebaseAuth.signOut()` so the Firestore write still
  /// satisfies security rules. Never throws — logout must not be blocked.
  Future<void> clearTokenForCurrentUser() async {
    try {
      final uid = _auth.currentUser?.uid;
      final token = _currentToken ?? await _messaging.getToken();
      if (uid != null && token != null && token.isNotEmpty) {
        await _tokenCollection(uid).doc(_docIdFor(token)).delete();
      }
      await _messaging.deleteToken();
      _currentToken = null;
      debugPrint('✅ [FCM] token cleared on logout');
    } catch (e) {
      debugPrint('❌ [FCM] clearToken failed: $e');
    }
  }

  // ───────────────────────────── Receiving ─────────────────────────────

  void _onForegroundMessage(RemoteMessage message) {
    // On iOS the system presents the alert itself while the app is in the
    // foreground (see setForegroundNotificationPresentationOptions above);
    // only Android needs a manually-drawn heads-up notification.
    if (defaultTargetPlatform != TargetPlatform.android) return;

    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
          icon: 'ic_notification',
          color: const Color(0xFF2F6BFF),
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  // ───────────────────────────── Deep linking ─────────────────────────────

  /// Consumes a notification that launched the app from a terminated state.
  /// Call this from SplashViewModel *after* the user has been routed home, so
  /// the deep-link target is pushed onto a navigator that already exists.
  Future<void> handleLaunchDeepLink() async {
    final message = _pendingMessage;
    if (message == null) return;
    _pendingMessage = null;
    await _routeFromData(message.data);
  }

  void _handleMessageTap(RemoteMessage message) => _routeFromData(message.data);

  /// Routes a notification tap to the relevant classroom screen:
  ///  • `lesson` / `quiz` -> student classroom detail
  ///  • `quiz_result`     -> teacher classroom detail
  ///
  /// Fully guarded — a routing failure can never crash the app; it just
  /// leaves the user wherever they already were.
  Future<void> _routeFromData(Map<String, dynamic> data) async {
    try {
      final type = data['type']?.toString();
      final classId = data['classId']?.toString();
      debugPrint('🔔 [FCM] notification tapped: type=$type class=$classId');
      if (classId == null || classId.isEmpty) return;

      final classroom = await _loadClassroomMap(classId);
      if (classroom == null) return;

      final navigation = locator<NavigationService>();
      switch (type) {
        case 'lesson':
        case 'quiz':
          await navigation.navigateToStudentClassroomDetaiView(
            classroom: classroom,
          );
          break;
        case 'quiz_result':
          await navigation.navigateToClassroomdetailView(
            classroom: classroom,
          );
          break;
        default:
          break;
      }
    } catch (e) {
      debugPrint('❌ [FCM] deep-link failed: $e');
    }
  }

  /// Builds the `classroom` argument map the classroom-detail views expect,
  /// straight from `classes/{classId}`.
  Future<Map<String, dynamic>?> _loadClassroomMap(String classId) async {
    final doc =
        await _firestore.collection(FirestoreKeys.classes).doc(classId).get();
    if (!doc.exists) return null;
    final data = doc.data() ?? <String, dynamic>{};
    return {
      ...data,
      'id': doc.id,
      'code': data[FirestoreKeys.classCode],
    };
  }
}

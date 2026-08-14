import 'dart:async';

import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/analytics_service.dart';
import 'package:englify_app/services/notification_service.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  // runZonedGuarded captures uncaught async errors and forwards them to
  // Crashlytics as fatal crashes.
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    // ── Crashlytics: route framework + platform errors here.
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    // ── App Check (NOT enforced — enforcement is a Firebase Console setting).
    // Activating the client lets it attach attestation tokens once enforcement
    // is later turned on. Guarded so it can never block start-up.
    try {
      await FirebaseAppCheck.instance.activate(
        providerAndroid: kDebugMode
            ? AndroidDebugProvider()
            : AndroidPlayIntegrityProvider(),
        providerApple: kDebugMode
            ? AppleDebugProvider()
            : AppleAppAttestProvider(),
      );
    } catch (e) {
      debugPrint('⚠️ App Check activate skipped: $e');
    }

    // Must be registered at the top level before runApp so the engine can
    // dispatch FCM messages received while the app is backgrounded / terminated.
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    setupLocator();

    // Sets up FCM channels, permission, listeners and token sync.
    // Not awaited — the permission dialog must not block the first frame.
    locator<NotificationService>().init();

    runApp(MyApp());
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}

/// The blue used for focused inputs across the app.
const _accentBlue = Color(0xFF2F6BFF);

/// App-wide theme.
///
/// Without this, MaterialApp falls back to Flutter's default purple seed, which
/// leaks into every input that doesn't override it — the cursor, the focused
/// border and the selection handles all render purple.
///
/// These are only DEFAULTS: a field that sets its own `cursorColor` or
/// `focusedBorder` still wins. That is deliberate — the auth and quiz fields sit
/// on dark backgrounds and stay white on purpose.
///
/// The focus colour is driven through `colorScheme.primary` rather than
/// `inputDecorationTheme.focusedBorder`. A focusedBorder in the theme would also
/// pin the corner radius, and the app's fields range from 10 to 30 — they would
/// visibly change shape the moment they were tapped. Going through `primary`
/// recolours the focus ring while each field keeps its own radius.
final _appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _accentBlue,
  ).copyWith(primary: _accentBlue),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Color(0x402F6BFF),
    selectionHandleColor: _accentBlue,
  ),
);

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _appTheme,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      // Automatic screen-view tracking for Firebase Analytics.
      navigatorObservers: [locator<AnalyticsService>().observer],
      builder: (context, child) {
        // Clamp OS text scaling so a user's system font-size setting can
        // never overflow layouts. The range stays accessible but layout-safe.
        final clampedTextScaler = MediaQuery.textScalerOf(context)
            .clamp(minScaleFactor: 0.9, maxScaleFactor: 1.3);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: clampedTextScaler),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}

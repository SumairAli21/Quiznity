import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/services/analytics_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AnalyticsService get _analytics => locator<AnalyticsService>();

  /// Every successful sign-in funnels through here so a previous account's
  /// cached data can never leak into the newly signed-in one.
  Future<void> _onSignedIn(User user, String method) async {
    await locator<LocalStorageService>().syncsession(user.uid);
    await _analytics.setUser(uid: user.uid);
    await _analytics.logLogin(method: method);
  }

  /// Records a non-fatal exception to Crashlytics without ever throwing.
  void _record(Object error, StackTrace stack, String reason) {
    try {
      FirebaseCrashlytics.instance
          .recordError(error, stack, reason: reason, fatal: false);
    } catch (_) {}
  }

  // Email/Password Login
  Future<User?> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user != null) await _onSignedIn(user, 'email');
      return user;
    } on FirebaseAuthException catch (e, s) {
      // Expected auth failures (wrong password etc.) are not crashes — log
      // lightly for diagnostics but don't spam Crashlytics with them.
      print('❌ Login error: ${e.code}');
      if (e.code != 'wrong-password' &&
          e.code != 'user-not-found' &&
          e.code != 'invalid-credential') {
        _record(e, s, 'login');
      }
      rethrow; // let the viewmodel surface a precise, user-facing message
    } catch (e, s) {
      print('❌ Login error: $e');
      _record(e, s, 'login');
      return null;
    }
  }

  // Email/Password Signup
  Future<User?> signup(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user != null) {
        await locator<LocalStorageService>().syncsession(user.uid);
        await _analytics.setUser(uid: user.uid);
        await _analytics.logSignUp(method: 'email');
      }
      return user;
    } on FirebaseAuthException catch (e, s) {
      print('❌ Signup error: ${e.code}');
      if (e.code != 'email-already-in-use' && e.code != 'weak-password') {
        _record(e, s, 'signup');
      }
      rethrow; // let the viewmodel surface a precise message
    } catch (e, s) {
      print('❌ Signup error: $e');
      _record(e, s, 'signup');
      return null;
    }
  }

  // ✅ Google Sign In
  Future<User?> signInWithGoogle() async {
    try {
      print("🔵 Starting Google Sign In...");

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print("❌ User cancelled");
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential result =
          await _auth.signInWithCredential(credential);
      final user = result.user;
      if (user != null) await _onSignedIn(user, 'google');
      return user;
    } catch (e, s) {
      print("❌ Google Sign In error: $e");
      _record(e, s, 'google_sign_in');
      return null;
    }
  }

  // ✅ Apple Sign In
  Future<User?> signInWithApple() async {
    try {
      print("🍎 Starting Apple Sign In...");

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential result =
          await _auth.signInWithCredential(oauthCredential);
      final user = result.user;
      if (user != null) await _onSignedIn(user, 'apple');
      return user;
    } catch (e, s) {
      print("❌ Apple Sign In error: $e");
      _record(e, s, 'apple_sign_in');
      return null;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      // Remove this device's FCM token before sign-out so the Firestore write
      // still satisfies security rules and the user stops receiving pushes
      // here. This call never throws, so logout always proceeds.
      await locator<NotificationService>().clearTokenForCurrentUser();
      await _googleSignIn.signOut();
      await _auth.signOut();
      await _analytics.logLogout();
      await _analytics.clearUser();
      print("✅ User signed out");
    } catch (e, s) {
      print("❌ Sign out error: $e");
      _record(e, s, 'sign_out');
    }
  }

  // ───────────────────────── Email verification ─────────────────────────

  /// True when the current user signed in with email/password (the only
  /// provider that needs an in-app verification step). Google/Apple accounts
  /// are verified by the identity provider.
  bool get isPasswordProvider =>
      _auth.currentUser?.providerData
          .any((p) => p.providerId == 'password') ??
      false;

  bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;

  /// Sends a verification email to the signed-in user. Never throws.
  Future<bool> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user == null || user.emailVerified) return false;
      await user.sendEmailVerification();
      print("✅ Verification email sent to ${user.email}");
      return true;
    } catch (e, s) {
      print("❌ sendEmailVerification failed: $e");
      _record(e, s, 'send_email_verification');
      return false;
    }
  }

  /// Reloads the user from Firebase and reports the latest verified status.
  Future<bool> reloadAndCheckVerified() async {
    try {
      await _auth.currentUser?.reload();
      return _auth.currentUser?.emailVerified ?? false;
    } catch (e, s) {
      print("❌ reloadAndCheckVerified failed: $e");
      _record(e, s, 'reload_user');
      return false;
    }
  }

  // ───────────────────────── Email update ─────────────────────────

  /// Starts Firebase's secure email-change flow. A verification link is sent
  /// to [newEmail]; the address only changes after the user clicks it.
  ///
  /// Returns:
  ///   • null                     → verification email sent successfully
  ///   • 'requires-recent-login'  → caller must re-authenticate then retry
  ///   • any other string         → user-facing error message
  Future<String?> updateEmail(String newEmail) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return 'No signed-in user.';
      await user.verifyBeforeUpdateEmail(newEmail);
      return null;
    } on FirebaseAuthException catch (e, s) {
      switch (e.code) {
        case 'requires-recent-login':
          return 'requires-recent-login';
        case 'invalid-email':
          return 'Please enter a valid email address.';
        case 'email-already-in-use':
          return 'That email is already in use by another account.';
        default:
          _record(e, s, 'update_email');
          return 'Could not update email. Please try again.';
      }
    } catch (e, s) {
      _record(e, s, 'update_email');
      return 'Could not update email. Please try again.';
    }
  }

  // ───────────────────────── Account deletion ─────────────────────────

  /// Re-authenticates a password user. Returns null on success, otherwise a
  /// user-facing error message.
  Future<String?> reauthenticateWithPassword(String password) async {
    try {
      final user = _auth.currentUser;
      final email = user?.email;
      if (user == null || email == null) return 'No signed-in user.';
      final cred =
          EmailAuthProvider.credential(email: email, password: password);
      await user.reauthenticateWithCredential(cred);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        return 'Incorrect password.';
      }
      return 'Re-authentication failed. Please try again.';
    } catch (e, s) {
      _record(e, s, 'reauth_password');
      return 'Re-authentication failed. Please try again.';
    }
  }

  /// Re-authenticates a Google user by re-running the Google flow. Returns null
  /// on success, otherwise a user-facing error message.
  Future<String?> reauthenticateWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return 'Re-authentication cancelled.';
      final googleAuth = await googleUser.authentication;
      final cred = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.currentUser?.reauthenticateWithCredential(cred);
      return null;
    } catch (e, s) {
      _record(e, s, 'reauth_google');
      return 'Re-authentication failed. Please try again.';
    }
  }

  /// Deletes the Firebase Auth account for the current user.
  ///
  /// Returns:
  ///   • null               → deleted successfully
  ///   • 'requires-recent-login' → caller must re-authenticate then retry
  ///   • any other string   → user-facing error message
  Future<String?> deleteAccount() async {
    try {
      // Best-effort token cleanup first so no orphan push tokens remain.
      await locator<NotificationService>().clearTokenForCurrentUser();
      await _auth.currentUser?.delete();
      await _analytics.clearUser();
      print("✅ Account deleted");
      return null;
    } on FirebaseAuthException catch (e, s) {
      if (e.code == 'requires-recent-login') return 'requires-recent-login';
      _record(e, s, 'delete_account');
      return 'Could not delete account. Please try again.';
    } catch (e, s) {
      _record(e, s, 'delete_account');
      return 'Could not delete account. Please try again.';
    }
  }

  User? get currentuser => _auth.currentUser;
}

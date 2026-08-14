import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/user_service.dart';
import 'package:englify_app/utils/student_routing.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// Drives the "verify your email" gate shown to email/password users after
/// signup (or after a login attempt while still unverified).
class EmailVerificationViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _userService = locator<UserService>();
  final _localStorage = locator<LocalStorageService>();

  String? errorMessage;
  String? infoMessage;
  int resendCooldown = 0;

  String get email => _authService.currentuser?.email ?? 'your email';

  bool get canResend => resendCooldown == 0 && !isBusy;

  /// Called once the screen is shown. The verification email is sent by the
  /// caller (signup / login gate) before navigating here, so we only start a
  /// short resend cooldown and do an initial silent status check.
  Future<void> init() async {
    _startCooldown();
    await checkVerified(silent: true);
  }

  /// Reloads the user and, if verified, completes the login and routes home.
  /// When [silent] is true, a still-unverified result shows no error (used for
  /// the automatic check on screen open).
  Future<void> checkVerified({bool silent = false}) async {
    setBusy(true);
    errorMessage = null;
    infoMessage = null;

    final verified = await _authService.reloadAndCheckVerified();
    setBusy(false);

    if (!verified) {
      if (!silent) {
        errorMessage = 'Not verified yet. Check your inbox, then tap again.';
      }
      notifyListeners();
      return;
    }

    await _completeAndRoute();
  }

  Future<void> _completeAndRoute() async {
    final user = _authService.currentuser;
    if (user == null) {
      _navigationService.replaceWithLoginView();
      return;
    }

    // Resolve role (Firestore is the source of truth; fall back to local cache).
    String? role = await _userService.getUserrole(user.uid);
    role ??= await _localStorage.getuserrole();

    await _localStorage.islogintrue();
    if (role != null) await _localStorage.saveuserrole(role);

    if (role == 'teacher') {
      _navigationService.replaceWithTeacherBottomTabView();
    } else if (role == 'student') {
      // Personalization is one-time; the shared router decides whether this
      // student still needs it. See lib/utils/student_routing.dart.
      await routeSignedInStudent(user.uid);
    } else {
      _navigationService.replaceWithRoleSelection();
    }
  }

  Future<void> resend() async {
    if (!canResend) return;
    setBusy(true);
    errorMessage = null;
    infoMessage = null;

    final sent = await _authService.sendEmailVerification();
    setBusy(false);

    if (sent) {
      infoMessage = 'Verification email sent.';
      _startCooldown();
    } else {
      errorMessage = 'Could not send email. Please try again shortly.';
    }
    notifyListeners();
  }

  void _startCooldown() {
    resendCooldown = 60;
    notifyListeners();
    _tickCooldown();
  }

  Future<void> _tickCooldown() async {
    while (resendCooldown > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (resendCooldown > 0) {
        resendCooldown--;
        notifyListeners();
      }
    }
  }

  /// Lets the user abandon this account and sign in with a different one.
  Future<void> useDifferentAccount() async {
    await _authService.signOut();
    await _localStorage.isloginfalse();
    _navigationService.clearStackAndShow(Routes.loginView);
  }
}

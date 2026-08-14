import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/user_service.dart';
import 'package:englify_app/utils/app_feedback.dart';
import 'package:englify_app/utils/student_routing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final _localstorageservice = locator<LocalStorageService>();
  final _userservice = locator<UserService>();
  final _authservice = locator<AuthService>();

  String? errormasage;
  bool isobsurce = true;

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  void toggle() {
    isobsurce = !isobsurce;
    notifyListeners();
  }

  void onforgate() {
    _navigationservice.navigateToForgotPasswordView();
  }

  void onsignout() {
    _navigationservice.replaceWithSignupemailview();
  }

  Future<void> onlogin(BuildContext context) async {
    final email = emailcontroller.text.trim();
    final password = passwordcontroller.text.trim();

    // Client-side validation — surface issues before hitting the network.
    if (email.isEmpty || !email.contains('@')) {
      errormasage = 'Enter a valid email address';
      notifyListeners();
      return;
    }
    if (password.isEmpty) {
      errormasage = 'Password is required';
      notifyListeners();
      return;
    }
    errormasage = null;
    notifyListeners();

    setBusy(true);
    try {
      final user = await _authservice.login(email, password);
      if (user == null) {
        setBusy(false);
        errormasage = 'Invalid email or password';
        notifyListeners();
        if (context.mounted) showAppSnackBar(context, errormasage!, isError: true);
        return;
      }

      // Email verification is kept but NON-BLOCKING: unverified email/password
      // users are still let in; a fresh verification email is sent as a nudge.
      if (_authservice.isPasswordProvider && !_authservice.isEmailVerified) {
        await _authservice.sendEmailVerification();
      }

      final role = await _userservice.getUserrole(user.uid);
      await _localstorageservice.islogintrue();
      if (role != null) await _localstorageservice.saveuserrole(role);

      setBusy(false);
      if (!context.mounted) return;

      if (role == 'student') {
        // Personalization is one-time — routeSignedInStudent decides whether
        // this student still needs it. See lib/utils/student_routing.dart.
        await routeSignedInStudent(user.uid);
      } else if (role == 'teacher') {
        _navigationservice.replaceWithTeacherBottomTabView();
      } else {
        // Profile doc missing/corrupt — previously this froze on the login
        // screen with no feedback. Route to role selection to recover.
        showAppSnackBar(context,
            'Your account setup is incomplete. Please pick your role.',
            isError: true);
        _navigationservice.replaceWithRoleSelection();
      }
    } on FirebaseAuthException catch (e) {
      setBusy(false);
      errormasage = authErrorMessage(e);
      notifyListeners();
      if (context.mounted) showAppSnackBar(context, errormasage!, isError: true);
    } on FirebaseException catch (e) {
      setBusy(false);
      if (context.mounted) {
        showAppSnackBar(context, firestoreErrorMessage(e), isError: true);
      }
    } catch (e) {
      setBusy(false);
      if (context.mounted) {
        showAppSnackBar(
            context, 'Something went wrong. Please try again.',
            isError: true);
      }
    }
  }

  void onemailchage(String value) {
    notifyListeners();
  }

  void onpasschage(String value) {
    notifyListeners();
  }

  void onback() {
    _navigationservice.back();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }
}

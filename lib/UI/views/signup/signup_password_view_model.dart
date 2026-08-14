import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/user_service.dart';
import 'package:englify_app/utils/app_feedback.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupPasswordViewModel extends BaseViewModel {
  String email;
  SignupPasswordViewModel({required this.email});
  final passwordcontroller = TextEditingController();
  final _navigationservice = locator<NavigationService>();
  final _localstorageservice = locator<LocalStorageService>();
  final _authservice = locator<AuthService>();
  final _userservice = locator<UserService>();

  bool isobscure = true;
  String? role;

  Future<void> init() async {
    role = await _localstorageservice.getuserrole();
    print("ROLE FROM LOCAL STORAGE: $role");
  }

  bool get hasminilenght => passwordcontroller.text.length >= 8;
  bool get hasuppercase => passwordcontroller.text.contains(RegExp(r'[A-Z]'));
  bool get haslowercase => passwordcontroller.text.contains(RegExp(r'[a-z]'));
  bool get hasnumber => passwordcontroller.text.contains(RegExp(r'[0-9]'));

  bool get ispassvalid =>
      hasminilenght && hasuppercase && haslowercase && hasnumber;

  void togglevisibality() {
    isobscure = !isobscure;
    notifyListeners();
  }

  void onchangepass(String value) {
    notifyListeners();
  }

  Future<void> oncreate(BuildContext context) async {
    // Validation feedback — these were previously silent early-returns.
    if (role == null) {
      showAppSnackBar(context,
          'Please go back and choose whether you are a student or teacher.',
          isError: true);
      return;
    }
    if (!ispassvalid) {
      showAppSnackBar(context,
          'Password must be 8+ characters with upper, lower and a number.',
          isError: true);
      return;
    }

    setBusy(true);
    try {
      final user = await _authservice.signup(
        email,
        passwordcontroller.text.trim(),
      );

      if (user == null) {
        setBusy(false);
        if (context.mounted) {
          showAppSnackBar(context,
              'Could not create your account. Please try again.',
              isError: true);
        }
        return;
      }

      await _userservice.createuser(email: email, uid: user.uid, role: role!);
      await _localstorageservice.islogintrue();
      await _localstorageservice.saveuserrole(role!);

      // Email verification kept but NON-BLOCKING: send the link now, but let
      // the user straight into the app instead of gating them.
      await _authservice.sendEmailVerification();

      setBusy(false);
      if (!context.mounted) return;

      if (role == 'teacher') {
        _navigationservice.replaceWithTeacherBottomTabView();
      } else {
        _navigationservice.replaceWithPersonalizationView();
      }
    } on FirebaseAuthException catch (e) {
      setBusy(false);
      if (context.mounted) {
        showAppSnackBar(context, authErrorMessage(e), isError: true);
      }
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

  void onback() {
    _navigationservice.back();
  }

  void onnavigatetoterms() {
    _navigationservice.navigateToTermsandcondView();
  }

  void onnavigatetoprivecy() {
    _navigationservice.navigateToPrivecyandpolicyView();
  }
}

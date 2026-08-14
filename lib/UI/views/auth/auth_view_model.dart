import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/user_service.dart';
import 'package:englify_app/utils/student_routing.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final _authservice = locator<AuthService>();
  final _localstorageservice = locator<LocalStorageService>();
  final _userservice = locator<UserService>();

  String? errorMessage;

  void continuewithemail() {
    _navigationservice.navigateToSignupemailview();
  }

  void onnavigatetoterms() {
    _navigationservice.navigateToTermsandcondView();
  }

  void onnavigatetoprivecy() {
    _navigationservice.navigateToPrivecyandpolicyView();
  }

  // ✅ UPDATED - Google Sign In
  Future<void> signInWithGoogle() async {
    errorMessage = null;
    setBusy(true);
    notifyListeners();

    try {
      print("\n🔵 ===== GOOGLE SIGN IN STARTED =====");
      
      // Step 1: Sign in with Google
      final user = await _authservice.signInWithGoogle();

      if (user == null) {
        print("❌ Sign in cancelled or failed");
        setBusy(false);
        errorMessage = "Sign in cancelled";
        notifyListeners();
        return;
      }

      print("✅ User signed in: ${user.email}");
      print("🔍 Checking user role in Firestore...");

      // Step 2: Check if user has role in Firestore
      final existingRole = await _userservice.getUserrole(user.uid);

      if (existingRole != null) {
        // ✅ Existing user - already has role in Firestore
        print("✅ Existing user found - Role: $existingRole");
        await _handleExistingUser(user.uid, existingRole);
      } else {
        // ✅ New user - get role from LOCAL STORAGE and save to Firestore
        print("🆕 New user - checking local storage for pre-selected role");
        
        final preSelectedRole = await _localstorageservice.getuserrole();
        
        if (preSelectedRole != null) {
          print("✅ Pre-selected role found: $preSelectedRole");
          print("💾 Saving role to Firestore...");
          
          // Save role to Firestore
          await _userservice.createuser(
            email: user.email!,
            uid: user.uid,
            role: preSelectedRole,
          );
          
          print("✅ Role saved to Firestore");
          
          // Mark as logged in
          await _localstorageservice.islogintrue();
          
          setBusy(false);
          notifyListeners();
          
          // Navigate based on role
          if (preSelectedRole == "student") {
            print("➡️ Navigating to Personalization (Student)");
            _navigationservice.replaceWithPersonalizationView();
          } else if (preSelectedRole == "teacher") {
            print("➡️ Navigating to Teacher Home");
            _navigationservice.replaceWithTeacherBottomTabView();
          }
        } else {
          // Should not happen, but fallback to role selection
          print("⚠️ No role found - redirecting to role selection");
          _navigationservice.replaceWithRoleSelection();
        }
      }

      print("===== GOOGLE SIGN IN COMPLETED =====\n");

    } catch (e) {
      print("❌ Error: $e");
      print("===== GOOGLE SIGN IN FAILED =====\n");
      setBusy(false);
      errorMessage = "Sign in failed. Please try again.";
      notifyListeners();
    }
  }

  // ✅ UPDATED - Apple Sign In
  Future<void> signInWithApple() async {
    errorMessage = null;
    setBusy(true);
    notifyListeners();

    try {
      print("\n🍎 ===== APPLE SIGN IN STARTED =====");
      
      final user = await _authservice.signInWithApple();

      if (user == null) {
        print("❌ Sign in cancelled or failed");
        setBusy(false);
        errorMessage = "Sign in cancelled";
        notifyListeners();
        return;
      }

      print("✅ User signed in: ${user.email}");
      print("🔍 Checking user role in Firestore...");

      final existingRole = await _userservice.getUserrole(user.uid);

      if (existingRole != null) {
        print("✅ Existing user found - Role: $existingRole");
        await _handleExistingUser(user.uid, existingRole);
      } else {
        print("🆕 New user - checking local storage for pre-selected role");
        
        final preSelectedRole = await _localstorageservice.getuserrole();
        
        if (preSelectedRole != null) {
          print("✅ Pre-selected role found: $preSelectedRole");
          print("💾 Saving role to Firestore...");
          
          await _userservice.createuser(
            email: user.email!,
            uid: user.uid,
            role: preSelectedRole,
          );
          
          print("✅ Role saved to Firestore");
          
          await _localstorageservice.islogintrue();
          
          setBusy(false);
          notifyListeners();
          
          if (preSelectedRole == "student") {
            print("➡️ Navigating to Personalization (Student)");
            _navigationservice.replaceWithPersonalizationView();
          } else if (preSelectedRole == "teacher") {
            print("➡️ Navigating to Teacher Home");
            _navigationservice.replaceWithTeacherBottomTabView();
          }
        } else {
          print("⚠️ No role found - redirecting to role selection");
          _navigationservice.replaceWithRoleSelection();
        }
      }

      print("===== APPLE SIGN IN COMPLETED =====\n");

    } catch (e) {
      print("❌ Error: $e");
      print("===== APPLE SIGN IN FAILED =====\n");
      setBusy(false);
      errorMessage = "Sign in failed. Please try again.";
      notifyListeners();
    }
  }

  // ✅ Helper - Handle existing user navigation
  Future<void> _handleExistingUser(String uid, String role) async {
    try {
      await _localstorageservice.islogintrue();
      await _localstorageservice.saveuserrole(role);

      setBusy(false);
      notifyListeners();

      if (role == "student") {
        // Returning student — personalization is one-time, so let the shared
        // router decide. See lib/utils/student_routing.dart.
        await routeSignedInStudent(uid);
      } else if (role == "teacher") {
        print("➡️ Navigating to Teacher Home");
        _navigationservice.replaceWithTeacherBottomTabView();
      } else {
        print("⚠️ Unknown role: $role");
        errorMessage = "Invalid user role";
        notifyListeners();
      }
    } catch (e) {
      print("❌ Navigation error: $e");
      setBusy(false);
      errorMessage = "Navigation failed";
      notifyListeners();
    }
  }

}

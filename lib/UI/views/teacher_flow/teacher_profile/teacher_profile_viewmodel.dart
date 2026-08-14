import 'dart:io';

import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/notification_service.dart';
import 'package:englify_app/services/profile_service.dart';
import 'package:englify_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TeacherProfileViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _localStorage = locator<LocalStorageService>();
  final _profileService = locator<ProfileService>();
  final _userService = locator<UserService>();
  final _notificationService = locator<NotificationService>();

  /// True for email/password accounts (need a password to re-authenticate
  /// before deletion). Google accounts re-auth via the Google flow instead.
  bool get isPasswordAccount => _authService.isPasswordProvider;

  String username = '';
  String location = '';
  String email = '';
  String? profileImageUrl;
  bool isGoogleAccount = false;
  bool isUploadingImage = false;
  bool isUpdatingEmail = false;
  bool isNotificationEnabled = true;

  Future<void> init() async {
    setBusy(true);
    try {
      // Current email from Firebase Authentication
      email = _authService.currentuser?.email ?? '';

      // Firestore se profile load karo
      final profile = await _profileService.getProfile();
      if (profile != null) {
        profileImageUrl = profile['profileImageUrl'] as String?;
        location = profile['location'] as String? ?? '';
      }

      // Firestore is the source of truth for the name — it is stored per-uid.
      // Local storage is only a cache, so it is the fallback, never the lead.
      final firestorename = (profile?['name'] as String?)?.trim();
      if (firestorename != null && firestorename.isNotEmpty) {
        username = firestorename;
        await _localStorage.saveusername(firestorename);
      } else {
        username = await _localStorage.getusername() ?? 'Teacher';
      }

      isGoogleAccount = await _profileService.isGoogleAccount();

      // Restore the saved notification preference — without this the switch
      // springs back to ON every launch.
      isNotificationEnabled = await _notificationService.isEnabled();
    } catch (e) {
      print('Failed to init teacher profile: $e');
    }
    setBusy(false);
  }

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (picked == null) return;

    isUploadingImage = true;
    notifyListeners();

    final url = await _profileService.uploadProfileImage(File(picked.path));
    if (url != null) {
      profileImageUrl = url;
      await _profileService.saveProfile(imageUrl: url);
    }

    isUploadingImage = false;
    notifyListeners();
  }

  // Username update — local storage + Firestore dono mein
  Future<void> updateUsername(String newUsername) async {
    final name = newUsername.trim();
    if (name.isEmpty) return;
    username = name;
    notifyListeners();
    await _localStorage.saveusername(name);
    // Firestore too, else the dashboard keeps reading the old name.
    await _profileService.saveProfile(name: name);
  }

  Future<void> updateLocation(String newLocation) async {
    location = newLocation;
    notifyListeners();
    await _profileService.saveProfile(location: newLocation);
  }

  /// Updates the account email through Firebase's secure verification flow.
  /// Re-authenticates first where required (a [password] is supplied on the
  /// retry for password accounts; Google accounts re-auth via the Google flow).
  ///
  /// Returns:
  ///   • null                     → verification link sent to [newEmail]
  ///   • 'requires-recent-login'  → view must collect the password and retry
  ///   • any other string         → user-facing error message
  Future<String?> updateEmail(String newEmail, {String? password}) async {
    final trimmed = newEmail.trim();
    if (trimmed.isEmpty) return 'Please enter an email address.';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(trimmed)) {
      return 'Please enter a valid email address.';
    }
    if (trimmed == email) return 'That is already your email.';

    isUpdatingEmail = true;
    notifyListeners();
    try {
      // Retry path: re-authenticate up front when a password was provided.
      if (isPasswordAccount && password != null) {
        final reErr = await _authService.reauthenticateWithPassword(password);
        if (reErr != null) return reErr;
      }

      var err = await _authService.updateEmail(trimmed);
      if (err == 'requires-recent-login') {
        if (isPasswordAccount) {
          return 'requires-recent-login'; // view will ask for the password
        }
        if (isGoogleAccount) {
          final reErr = await _authService.reauthenticateWithGoogle();
          if (reErr != null) return reErr;
          err = await _authService.updateEmail(trimmed);
        } else {
          return 'Please log in again, then retry updating your email.';
        }
      }
      return err;
    } finally {
      isUpdatingEmail = false;
      notifyListeners();
    }
  }

  // Actually registers/removes this device's FCM token, so switching it off
  // stops pushes arriving rather than just flipping a switch in the UI. The
  // choice is persisted and survives a restart.
  Future<void> toggleNotification() async {
    final enabled = !isNotificationEnabled;
    isNotificationEnabled = enabled;
    notifyListeners();

    await _notificationService.setEnabled(enabled);
  }

  void onRules() {
    _navigationService.navigateToRulesView();
  }

  void onFeedback() {
    _navigationService.navigateToFeedbackView();
  }

  void onSettings() {}
  void onTerms() => _navigationService.navigateToTermsandcondView();
  void onPrivacy() => _navigationService.navigateToPrivecyandpolicyView();

  void onChangePassword() {
    if (isGoogleAccount) return;
    _navigationService.navigateToChangePasswordView();
  }

  Future<void> logout(BuildContext context) async {
    setBusy(true);
    try {
      await _authService.signOut();
      await _localStorage.isloginfalse();
      await _localStorage.clearusername();
      await _localStorage.clearuserrole();
      await _localStorage.clearclassroomjoin();
      _navigationService.clearStackAndShow(Routes.roleSelection);
    } catch (e) {
      print('Failed to logout: $e');
    }
    setBusy(false);
  }

  /// Permanently deletes the account and its Firestore data. Re-authenticates
  /// first where required. Returns null on success, otherwise a user-facing
  /// error message (the view shows it via a SnackBar).
  Future<String?> deleteAccount({String? password}) async {
    setBusy(true);
    try {
      final uid = _authService.currentuser?.uid;

      // Re-authenticate so account deletion isn't rejected as stale.
      if (isPasswordAccount && password != null) {
        final err = await _authService.reauthenticateWithPassword(password);
        if (err != null) {
          setBusy(false);
          return err;
        }
      } else if (isGoogleAccount) {
        final err = await _authService.reauthenticateWithGoogle();
        if (err != null) {
          setBusy(false);
          return err;
        }
      }

      // Delete Firestore footprint while still authenticated, then the account.
      if (uid != null) await _userService.deleteUserData(uid);
      final delErr = await _authService.deleteAccount();
      if (delErr != null) {
        setBusy(false);
        return delErr == 'requires-recent-login'
            ? 'Please re-authenticate and try again.'
            : delErr;
      }

      await _localStorage.isloginfalse();
      await _localStorage.clearusername();
      await _localStorage.clearuserrole();
      await _localStorage.clearclassroomjoin();
      setBusy(false);
      _navigationService.clearStackAndShow(Routes.roleSelection);
      return null;
    } catch (e) {
      print('Failed to delete account: $e');
      setBusy(false);
      return 'Could not delete account. Please try again.';
    }
  }
}

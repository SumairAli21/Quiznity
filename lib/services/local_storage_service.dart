import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _firstLaunchKey = 'first_launch';
  // first launch(user open app for first time or not ?)
  Future<bool> isfirstlaunch() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(_firstLaunchKey) ?? true;
  }

  Future<void> setfirstlaunchfalse() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_firstLaunchKey, false);
  }

  // role selection
  static const _userRoleKey = 'user_role';

  Future<String?> getuserrole() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_userRoleKey);
  }

  Future<void> saveuserrole(String role) async {
    final perf = await SharedPreferences.getInstance();
    await perf.setString(_userRoleKey, role);
  }

  Future<void> clearuserrole() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_userRoleKey);
  }

  // user islogin?
  static const _isloginKey = "islogin";

  Future<bool> getislogin() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(_isloginKey) ?? false;
  }

  Future<void> islogintrue() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_isloginKey, true);
  }

  
  Future<void> isloginfalse() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_isloginKey, false);
  }

  // account identity — the uid that the cached user data below belongs to
  static const _lastuidkey = "last_uid";

  /// Drops per-account cached data when the signed-in account changes.
  ///
  /// Must run on every successful sign-in. Without it, a previous account's
  /// cached name/classroom state leaks into the next account when the user
  /// switches without logging out first.
  ///
  /// The role is deliberately NOT cleared: on first sign-up it is chosen
  /// before auth happens, and for an existing user it is overwritten from
  /// Firestore straight after sign-in.
  Future<void> syncsession(String uid) async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getString(_lastuidkey) != uid) {
      await pref.remove(_usernamekey);
      await pref.remove(classroomKey);
      await pref.remove(_notificationsenabledkey);
    }
    await pref.setString(_lastuidkey, uid);
  }

  // push notifications on/off (profile screen toggle)
  static const _notificationsenabledkey = "notifications_enabled";

  /// Defaults to true — a fresh install receives notifications until the user
  /// opts out.
  Future<bool> getnotificationsenabled() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(_notificationsenabledkey) ?? true;
  }

  Future<void> savenotificationsenabled(bool enabled) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(_notificationsenabledkey, enabled);
  }

  // user personalization
  static const _usernamekey = "user_name";

  Future<void> saveusername(String name) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_usernamekey, name);
  }

  Future<String?> getusername() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_usernamekey);
  }

  Future<void> clearuserdata() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

Future<void> clearusername() async {
  final pref = await SharedPreferences.getInstance();
  await pref.remove(_usernamekey);
}
  // isclassroom join
  static const classroomKey = "isclassroom_join";

  Future<void> setclassroomjointrue() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool(classroomKey, true);
  }

  Future<bool> isclassroomjoined() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(classroomKey) ?? false;
  }

  
  Future<void> clearclassroomjoin() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(classroomKey);
  }
}
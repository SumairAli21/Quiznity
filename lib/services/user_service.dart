import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Map<String, dynamic>> _users =
      _firestore.collection("users");

  Future<void> createuser({
    required String email,
    required String uid,
    required String role,
  }) async {
    // Validation before write — reject malformed input early.
    if (uid.trim().isEmpty) {
      throw ArgumentError('uid is required');
    }
    if (email.trim().isEmpty) {
      throw ArgumentError('email is required');
    }
    if (role != 'teacher' && role != 'student') {
      throw ArgumentError('role must be "teacher" or "student"');
    }

    await _users.doc(uid).set({
      'email': email.trim(),
      'role': role,
      'createdat': FieldValue.serverTimestamp(),
    });
  }

  Future<String?> getUserrole(String uid) async {
    final doc = await _users.doc(uid).get();
    return doc.data()?['role'] as String?;
  }

  /// The display name saved on `users/{uid}`, or null when the student has not
  /// completed personalization yet.
  ///
  /// Firestore is the source of truth for the name — `LocalStorageService`
  /// only mirrors it for fast reads, and that mirror is deliberately cleared
  /// by `syncsession` whenever the signed-in account changes. Routing must
  /// therefore ask Firestore, never the cache, or a returning student is sent
  /// back through personalization on every fresh session.
  ///
  /// Blank / whitespace-only names are treated as "not set" so a stray empty
  /// write can never lock a user out of the personalization step.
  Future<String?> getUserName(String uid) async {
    if (uid.trim().isEmpty) return null;
    final doc = await _users.doc(uid).get();
    final name = (doc.data()?['name'] as String?)?.trim();
    return (name == null || name.isEmpty) ? null : name;
  }

  /// Deletes the user's Firestore footprint (document + known subcollections).
  /// Call this while the user is still authenticated, before deleting the auth
  /// account, so security rules still permit the owner-scoped writes.
  /// Best-effort — never throws so account deletion can always proceed.
  Future<void> deleteUserData(String uid) async {
    try {
      final userRef = _users.doc(uid);
      for (final sub in const ['fcmTokens', 'favourites', 'quizResults']) {
        final snap = await userRef.collection(sub).get();
        for (final doc in snap.docs) {
          await doc.reference.delete();
        }
      }
      await userRef.delete();
      print("✅ User data deleted for $uid");
    } catch (e) {
      print("❌ deleteUserData failed: $e");
    }
  }
}

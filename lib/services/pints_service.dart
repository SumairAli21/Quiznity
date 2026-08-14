import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/services/analytics_service.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/firestore_keys.dart';

class PointsService {
  final _firestore = FirebaseFirestore.instance;
  final _authservice = locator<AuthService>();
  AnalyticsService get _analytics => locator<AnalyticsService>();

  Future<int> gettotalcoin() async {
    try {
      final user = _authservice.currentuser;
      if (user == null) return 0;
      final doc = await _firestore
          .collection(FirestoreKeys.users)
          .doc(user.uid)
          .get();
      return (doc.data()?['totalCoins'] as num?)?.toInt() ?? 0;
    } catch (e) {
      print('❌ failed to get user points: $e');
      return 0;
    }
  }

  Future<int?> getquizpoints(String lessonid) async {
    try {
      final user = _authservice.currentuser;
      if (user == null) return null;
      final doc = await _firestore
          .collection(FirestoreKeys.users)
          .doc(user.uid)
          .collection('quizResults')
          .doc(lessonid)
          .get();
      if (!doc.exists) return null;
      return (doc.data()?['score'] as num?)?.toInt();
    } catch (e) {
      print('❌ failed to get student quiz score: $e');
      return null;
    }
  }

  /// Saves quiz result in TWO places:
  ///
  /// 1. users/{studentId}/quizResults/{lessonId}
  ///    → student's own record
  ///
  /// 2. lessons/{lessonId}/quizResults/{studentId}
  ///    → teacher dashboard + quiz tracker read from here
  ///    (lessons are top-level collection with classId field)
  ///
  /// [lessonTitle] and [answers] are optional — when supplied they are
  /// denormalised onto record (2) so the Teacher Quiz Tracker can show
  /// per-question detail without re-reading the quiz definition.
  Future<void> savequizresult({
    required String lessonId,
    required String classId,
    required int score,
    required int totalPoints,
    String? lessonTitle,
    List<Map<String, dynamic>>? answers,
  }) async {
    try {
      final user = _authservice.currentuser;
      if (user == null) {
        print('❌ savequizresult: user is null');
        return;
      }
      final studentId = user.uid;
      final now = FieldValue.serverTimestamp();

      // Resolve a display name to denormalise onto the teacher-facing record.
      String studentName = '';
      try {
        final userDoc = await _firestore
            .collection(FirestoreKeys.users)
            .doc(studentId)
            .get();
        final ud = userDoc.data();
        if (ud != null) {
          final n = (ud['name'] as String?)?.trim();
          studentName = (n != null && n.isNotEmpty)
              ? n
              : ((ud['displayName'] as String?)?.trim() ??
                  (ud['username'] as String?)?.trim() ??
                  (ud['email'] as String?)?.trim() ??
                  '');
        }
      } catch (e) {
        print('⚠️ savequizresult: could not resolve student name: $e');
      }

      // ── 1. Student's own record (for student-side display)
      await _firestore
          .collection(FirestoreKeys.users)
          .doc(studentId)
          .collection('quizResults')
          .doc(lessonId)
          .set({
        'lessonId': lessonId,
        'classId': classId,
        'score': score,
        'totalPoints': totalPoints,
        'attemptedAt': now,
        'attemptCount': FieldValue.increment(1),
      }, SetOptions(merge: true));

      // ── 2. Top-level lessons/{lessonId}/quizResults/{studentId}
      //    DashboardService + TrackerService read quizResults from this path
      await _firestore
          .collection(FirestoreKeys.lessons)
          .doc(lessonId)
          .collection('quizResults')
          .doc(studentId)
          .set({
        'studentId': studentId,
        'studentName': studentName,
        'lessonId': lessonId,
        'lessonTitle': lessonTitle ?? '',
        'classId': classId,
        'score': score,
        'totalPoints': totalPoints,
        'attemptedAt': now,
        'attemptCount': FieldValue.increment(1),
        'answers': answers ?? const [],
      }, SetOptions(merge: true));

      // ── 3. Update student total coins
      await _firestore
          .collection(FirestoreKeys.users)
          .doc(studentId)
          .set({'totalCoins': FieldValue.increment(score)},
              SetOptions(merge: true));

      await _analytics.logQuizSubmit(score: score, total: totalPoints);

      print('✅ Quiz saved — student: $studentId | score: $score/$totalPoints');
    } catch (e) {
      print('❌ Failed to save quiz result: $e');
    }
  }

  Future<bool> isquizattempted(String lessonid) async {
    try {
      final user = _authservice.currentuser;
      if (user == null) return false;
      final doc = await _firestore
          .collection(FirestoreKeys.users)
          .doc(user.uid)
          .collection('quizResults')
          .doc(lessonid)
          .get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }
}
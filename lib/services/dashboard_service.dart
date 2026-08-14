import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/services/firestore_keys.dart';

class DashboardService {
  final _db = FirebaseFirestore.instance;

  // ─────────────────────────────────────────────
  // HELPER: lessons for a class
  // Lessons are top-level: lessons/ where classId == classId
  // ─────────────────────────────────────────────
  Future<List<QueryDocumentSnapshot>> _getLessons(String classId) async {
    final snap = await _db
        .collection(FirestoreKeys.lessons)
        .where(FirestoreKeys.classId, isEqualTo: classId)
        .get();
    print('📂 lessons for class $classId: ${snap.docs.length}');
    return snap.docs;
  }

  // ─────────────────────────────────────────────
  // HELPER: quizResults for a lesson
  // Path: lessons/{lessonId}/quizResults
  // Written by fixed PointsService
  // ─────────────────────────────────────────────
  Future<List<QueryDocumentSnapshot>> _getQuizResults(String lessonId,
      {DateTime? date}) async {
    Query query = _db
        .collection(FirestoreKeys.lessons)
        .doc(lessonId)
        .collection('quizResults');

    // When a date is supplied, keep only results attempted on that calendar
    // day. `attemptedAt` is written as a server timestamp by PointsService.
    if (date != null) {
      final start = DateTime(date.year, date.month, date.day);
      final end = start.add(const Duration(days: 1));
      query = query
          .where('attemptedAt',
              isGreaterThanOrEqualTo: Timestamp.fromDate(start))
          .where('attemptedAt', isLessThan: Timestamp.fromDate(end));
    }

    final snap = await query.get();
    return snap.docs;
  }

  // ─────────────────────────────────────────────
  // HELPER: single student quiz result for a lesson
  // ─────────────────────────────────────────────
  Future<Map<String, dynamic>?> _getStudentQuizResult({
    required String lessonId,
    required String studentId,
    required String classId,
  }) async {
    // Primary: lessons/{lessonId}/quizResults/{studentId}
    final primary = await _db
        .collection(FirestoreKeys.lessons)
        .doc(lessonId)
        .collection('quizResults')
        .doc(studentId)
        .get();

    if (primary.exists) return primary.data();

    // Fallback: users/{studentId}/quizResults/{lessonId}
    // (for data saved before PointsService fix)
    final fallback = await _db
        .collection(FirestoreKeys.users)
        .doc(studentId)
        .collection('quizResults')
        .doc(lessonId)
        .get();

    if (fallback.exists) {
      final d = fallback.data()!;
      // Only count if it belongs to this class
      if (d['classId'] == classId) return d;
    }

    return null;
  }

  // ─────────────────────────────────────────────
  // 1. Total classrooms
  // ─────────────────────────────────────────────
  Future<int> getTotalClassrooms(String teacherId) async {
    final snap = await _db
        .collection('classes')
        .where('teacherId', isEqualTo: teacherId)
        .get();
    print('📊 getTotalClassrooms: ${snap.docs.length}');
    return snap.docs.length;
  }

  // ─────────────────────────────────────────────
  // 2. Total unique students
  // ─────────────────────────────────────────────
  Future<int> getTotalStudents(String teacherId) async {
    final classes = await _db
        .collection('classes')
        .where('teacherId', isEqualTo: teacherId)
        .get();

    final Set<String> studentIds = {};
    for (final cls in classes.docs) {
      final members = await _db
          .collection('classes')
          .doc(cls.id)
          .collection('members')
          .where('role', isEqualTo: 'student')
          .get();
      for (final m in members.docs) studentIds.add(m.id);
    }
    print('📊 getTotalStudents: ${studentIds.length}');
    return studentIds.length;
  }

  // ─────────────────────────────────────────────
  // 3. Average Score
  // ─────────────────────────────────────────────
  Future<double> getAverageScore(String teacherId, {DateTime? date}) async {
    final classes = await _db
        .collection('classes')
        .where('teacherId', isEqualTo: teacherId)
        .get();

    int totalEarned = 0;
    int totalPossible = 0;

    for (final cls in classes.docs) {
      final lessons = await _getLessons(cls.id);
      for (final lesson in lessons) {
        final results = await _getQuizResults(lesson.id, date: date);
        print(
            '📊 class "${cls.data()['name']}" lesson ${lesson.id}: ${results.length} results');
        for (final r in results) {
          final d = r.data() as Map<String, dynamic>;
          totalEarned += (d['score'] as num?)?.toInt() ?? 0;
          totalPossible += (d['totalPoints'] as num?)?.toInt() ?? 100;
        }
      }
    }

    if (totalPossible == 0) return 0.0;
    final avg = (totalEarned / totalPossible) * 100;
    print('📊 getAverageScore: $avg%');
    return avg;
  }

  // ─────────────────────────────────────────────
  // 4. Average Attendance
  // ─────────────────────────────────────────────
  Future<double> getAverageAttendance(String teacherId,
      {DateTime? date}) async {
    final classes = await _db
        .collection('classes')
        .where('teacherId', isEqualTo: teacherId)
        .get();

    final Set<String> allEnrolled = {};
    final Set<String> attempted = {};

    for (final cls in classes.docs) {
      final members = await _db
          .collection('classes')
          .doc(cls.id)
          .collection('members')
          .where('role', isEqualTo: 'student')
          .get();
      for (final m in members.docs) allEnrolled.add(m.id);

      final lessons = await _getLessons(cls.id);
      for (final lesson in lessons) {
        final results = await _getQuizResults(lesson.id, date: date);
        for (final r in results) attempted.add(r.id); // doc id = studentId
      }
    }

    if (allEnrolled.isEmpty) return 0.0;
    final pct = (attempted.length / allEnrolled.length) * 100;
    final capped = pct > 100 ? 100.0 : pct;
    print(
        '📊 getAverageAttendance: $capped% (${attempted.length}/${allEnrolled.length})');
    return capped;
  }

  // ─────────────────────────────────────────────
  // 5. Top Performing Class
  // ─────────────────────────────────────────────
  Future<TopClassInfo?> getTopPerformingClass(String teacherId,
      {DateTime? date}) async {
    final classes = await _db
        .collection('classes')
        .where('teacherId', isEqualTo: teacherId)
        .get();

    TopClassInfo? top;
    double topScore = -1;

    for (final cls in classes.docs) {
      final lessons = await _getLessons(cls.id);
      int earned = 0;
      int possible = 0;

      for (final lesson in lessons) {
        final results = await _getQuizResults(lesson.id, date: date);
        for (final r in results) {
          final d = r.data() as Map<String, dynamic>;
          earned += (d['score'] as num?)?.toInt() ?? 0;
          possible += (d['totalPoints'] as num?)?.toInt() ?? 100;
        }
      }

      final avg = possible == 0 ? 0.0 : (earned / possible) * 100;
      print('📊 class "${cls.data()['name']}": avg=$avg% ($earned/$possible)');

      if (avg > topScore) {
        topScore = avg;
        top = TopClassInfo(
          classId: cls.id,
          className: cls.data()['name'] ?? 'Class',
          averageScore: avg,
        );
      }
    }
    return top;
  }

  // ─────────────────────────────────────────────
  // 6. All students listing
  // ─────────────────────────────────────────────
  Future<List<StudentSummary>> getAllStudents(String teacherId) async {
    final classes = await _db
        .collection('classes')
        .where('teacherId', isEqualTo: teacherId)
        .get();

    final Map<String, StudentSummary> studentMap = {};

    for (final cls in classes.docs) {
      final className = cls.data()['name'] ?? '';

      final members = await _db
          .collection('classes')
          .doc(cls.id)
          .collection('members')
          .where('role', isEqualTo: 'student')
          .get();

      for (final m in members.docs) {
        final studentId = m.id;

        if (studentMap.containsKey(studentId)) {
          if (!studentMap[studentId]!.classNames.contains(className)) {
            studentMap[studentId]!.classNames.add(className);
          }
          continue;
        }

        final userDoc =
            await _db.collection(FirestoreKeys.users).doc(studentId).get();
        if (!userDoc.exists) {
          print('⚠️ user doc not found: $studentId');
          continue;
        }

        final data = userDoc.data()!;
        // Try multiple possible name fields
        final name = (data['name'] as String?)?.trim().isNotEmpty == true
            ? data['name']
            : (data['displayName'] as String?)?.trim().isNotEmpty == true
                ? data['displayName']
                : data['username'] ?? 'Student';

        print('👤 student: $name | coins: ${data['totalCoins']}');

        studentMap[studentId] = StudentSummary(
          studentId: studentId,
          name: name,
          // Try multiple possible image fields
          profileImage: data['profileImageUrl'] ??
              data['photoURL'] ??
              data['profileImage'] ??
              '',
          level: (data['level'] as num?)?.toInt() ?? 1,
          totalPoints: (data['totalCoins'] as num?)?.toInt() ?? 0,
          role: 'Student',
          classNames: [className],
        );
      }
    }
    return studentMap.values.toList();
  }

  // ─────────────────────────────────────────────
  // 7. Student Detail
  // ─────────────────────────────────────────────
  Future<StudentDetail> getStudentDetail({
    required String teacherId,
    required String studentId,
  }) async {
    final classes = await _db
        .collection('classes')
        .where('teacherId', isEqualTo: teacherId)
        .get();

    int totalLessons = 0;
    int completedLessons = 0;
    int totalQuizAttempts = 0;
    int firstTimeAttempts = 0;
    int earnedPoints = 0;
    int possiblePoints = 0;

    for (final cls in classes.docs) {
      // Check student is member of this class
      final memberDoc = await _db
          .collection('classes')
          .doc(cls.id)
          .collection('members')
          .doc(studentId)
          .get();

      if (!memberDoc.exists) continue;
      if (memberDoc.data()?['role'] != 'student') continue;

      print('✅ student $studentId in class "${cls.data()['name']}"');

      final lessons = await _getLessons(cls.id);
      totalLessons += lessons.length;
      print('📚 lessons: ${lessons.length}');

      for (final lesson in lessons) {
        // Quiz result — primary path then fallback
        final result = await _getStudentQuizResult(
          lessonId: lesson.id,
          studentId: studentId,
          classId: cls.id,
        );

        if (result != null) {
          totalQuizAttempts++;
          completedLessons++; // attempted quiz = completed lesson
          final s = (result['score'] as num?)?.toInt() ?? 0;
          final p = (result['totalPoints'] as num?)?.toInt() ?? 100;
          earnedPoints += s;
          possiblePoints += p;
          if ((result['attemptCount'] as num?)?.toInt() == 1) {
            firstTimeAttempts++;
          }
          print('🎯 quiz: score=$s/$p in lesson ${lesson.id}');
        }
      }
    }

    final performance =
        possiblePoints == 0 ? 0.0 : (earnedPoints / possiblePoints) * 100;
    final attendance =
        totalLessons == 0 ? 0.0 : (completedLessons / totalLessons) * 100;

    print(
        '📊 Detail: lessons=$completedLessons/$totalLessons, quizzes=$totalQuizAttempts, perf=$performance%');

    final userDoc =
        await _db.collection(FirestoreKeys.users).doc(studentId).get();
    final userData = userDoc.data() ?? {};

    final name = (userData['name'] as String?)?.trim().isNotEmpty == true
        ? userData['name']
        : (userData['displayName'] as String?)?.trim().isNotEmpty == true
            ? userData['displayName']
            : userData['username'] ?? 'Student';

    return StudentDetail(
      studentId: studentId,
      name: name,
      profileImage: userData['profileImageUrl'] ??
          userData['photoURL'] ??
          userData['profileImage'] ??
          '',
      level: (userData['level'] as num?)?.toInt() ?? 1,
      totalPoints: (userData['totalCoins'] as num?)?.toInt() ?? 0,
      location: userData['location'] ?? '',
      totalLessons: totalLessons,
      completedLessons: completedLessons,
      performance: performance,
      attendancePercent: attendance,
      averageScore: performance,
      totalQuizAttempts: totalQuizAttempts,
      firstTimeAttempts: firstTimeAttempts,
    );
  }
}

// ── Data models ──────────────────────────────

class TopClassInfo {
  final String classId;
  final String className;
  final double averageScore;
  TopClassInfo({
    required this.classId,
    required this.className,
    required this.averageScore,
  });
}

class StudentSummary {
  final String studentId;
  final String name;
  final String profileImage;
  final int level;
  final int totalPoints;
  final String role;
  final List<String> classNames;

  StudentSummary({
    required this.studentId,
    required this.name,
    required this.profileImage,
    required this.level,
    required this.totalPoints,
    required this.role,
    required this.classNames,
  });
}

class StudentDetail {
  final String studentId;
  final String name;
  final String profileImage;
  final int level;
  final int totalPoints;
  final String location;
  final int totalLessons;
  final int completedLessons;
  final double performance;
  final double attendancePercent;
  final double averageScore;
  final int totalQuizAttempts;
  final int firstTimeAttempts;

  StudentDetail({
    required this.studentId,
    required this.name,
    required this.profileImage,
    required this.level,
    required this.totalPoints,
    required this.location,
    required this.totalLessons,
    required this.completedLessons,
    required this.performance,
    required this.attendancePercent,
    required this.averageScore,
    required this.totalQuizAttempts,
    required this.firstTimeAttempts,
  });
}
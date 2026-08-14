import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/firestore_keys.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentDashboardViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _db = FirebaseFirestore.instance;

  // ── Student profile
  String studentName = '';
  int level = 1;
  int totalPoints = 0;

  // ── Stats
  int completedLessons = 0;
  int totalLessons = 0;
  double performance = 0.0; // avg score %

  // ── Top performing class
  String topClassName = '';
  String topClassId = '';
  double topClassScore = 0.0;

  /// When null the dashboard shows all-time data. When set, the lesson/score
  /// stats are limited to quizzes attempted on that calendar day. Mirrors the
  /// teacher dashboard.
  DateTime? selectedDate;

  String get studentId => _authService.currentuser?.uid ?? '';

  /// Live listener on the student's user doc. A quiz submission increments
  /// `totalCoins` on this doc (see PointsService.savequizresult), so listening
  /// keeps the points card fresh without needing the tab to be rebuilt — the
  /// dashboard is kept alive inside the bottom-nav IndexedStack, so a one-shot
  /// read would otherwise stay stale until app restart.
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _profileSub;

  /// The first snapshot merely echoes the value [_load] already fetched, so we
  /// skip it and only react to subsequent live changes.
  bool _profilePrimed = false;

  Future<void> init() async {
    await _load();
    _listenToProfile();
  }

  void _listenToProfile() {
    final id = studentId;
    if (id.isEmpty) return;
    _profilePrimed = false;
    _profileSub?.cancel();
    _profileSub = _db
        .collection(FirestoreKeys.users)
        .doc(id)
        .snapshots()
        .listen((doc) {
      if (!_profilePrimed) {
        _profilePrimed = true;
        return;
      }
      final data = doc.data() ?? {};
      studentName = data['name'] ?? data['displayName'] ?? 'Student';
      level = (data['level'] as num?)?.toInt() ?? 1;
      totalPoints = (data['totalCoins'] as num?)?.toInt() ?? 0;
      notifyListeners();
      // A quiz completion also writes a new quizResult, so refresh the
      // lesson-completion and performance stats off the same signal.
      _loadStats().then((_) => notifyListeners());
    });
  }

  Future<void> _load() async {
    setBusy(true);
    try {
      await Future.wait([
        _loadProfile(),
        _loadStats(),
      ]);
    } catch (e) {
      print('StudentDashboard init error: $e');
    }
    setBusy(false);
  }

  /// Opens the native date picker and reloads the dashboard for the chosen
  /// day. Cancelling leaves the current view untouched.
  Future<void> onCalendarTap(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(2020),
      lastDate: now,
    );
    if (picked == null) return;
    selectedDate = picked;
    await _load();
  }

  /// Clears the day filter and returns the dashboard to all-time data.
  Future<void> clearDateFilter() async {
    if (selectedDate == null) return;
    selectedDate = null;
    await _load();
  }

  /// True when [attemptedAt] falls on [selectedDate]. Results with no
  /// timestamp (written before PointsService started stamping them) are
  /// excluded from a filtered view rather than silently counted.
  bool _matchesSelectedDay(Object? attemptedAt) {
    final day = selectedDate;
    if (day == null) return true;
    if (attemptedAt is! Timestamp) return false;

    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    final at = attemptedAt.toDate();
    return !at.isBefore(start) && at.isBefore(end);
  }

  // ── Load student profile from users collection
  Future<void> _loadProfile() async {
    final doc = await _db
        .collection(FirestoreKeys.users)
        .doc(studentId)
        .get();
    final data = doc.data() ?? {};
    studentName = data['name'] ?? data['displayName'] ?? 'Student';
    level = (data['level'] as num?)?.toInt() ?? 1;
    totalPoints = (data['totalCoins'] as num?)?.toInt() ?? 0;
  }

  // ── Load lessons done, performance, top class
  Future<void> _loadStats() async {
    // Get all classes the student is in
    final allClasses = await _db.collection('classes').get();

    int totalL = 0;
    int completedL = 0;
    int earnedPoints = 0;
    int possiblePoints = 0;

    String bestClassId = '';
    String bestClassName = '';
    double bestScore = -1;

    for (final cls in allClasses.docs) {
      // Check if student is a member
      final memberDoc = await _db
          .collection('classes')
          .doc(cls.id)
          .collection('members')
          .doc(studentId)
          .get();

      if (!memberDoc.exists || memberDoc.data()?['role'] != 'student') {
        continue;
      }

      // Get lessons for this class (top-level lessons collection)
      final lessons = await _db
          .collection(FirestoreKeys.lessons)
          .where(FirestoreKeys.classId, isEqualTo: cls.id)
          .get();

      totalL += lessons.docs.length;

      int classEarned = 0;
      int classPossible = 0;

      for (final lesson in lessons.docs) {
        // Quiz result
        final resultDoc = await _db
            .collection(FirestoreKeys.lessons)
            .doc(lesson.id)
            .collection('quizResults')
            .doc(studentId)
            .get();

        if (resultDoc.exists) {
          final d = resultDoc.data()!;
          // Skip attempts outside the selected day when a filter is active.
          if (!_matchesSelectedDay(d['attemptedAt'])) continue;

          completedL++;
          final s = (d['score'] as num?)?.toInt() ?? 0;
          final p = (d['totalPoints'] as num?)?.toInt() ?? 100;
          earnedPoints += s;
          possiblePoints += p;
          classEarned += s;
          classPossible += p;
        }
      }

      // Check if this class is best
      if (classPossible > 0) {
        final classAvg = (classEarned / classPossible) * 100;
        if (classAvg > bestScore) {
          bestScore = classAvg;
          bestClassId = cls.id;
          bestClassName = cls.data()['name'] ?? 'Class';
        }
      }
    }

    totalLessons = totalL;
    completedLessons = completedL;
    performance = possiblePoints == 0
        ? 0.0
        : (earnedPoints / possiblePoints) * 100;

    topClassId = bestClassId;
    topClassName = bestClassName;
    topClassScore = bestScore < 0 ? 0.0 : bestScore;

    print(
        '📊 Student: lessons=$completedLessons/$totalLessons, perf=$performance%, topClass=$topClassName ($topClassScore%)');
  }

  void onContinueTap() {
    if (topClassId.isEmpty) return;
    _navigationService.navigateTo(
      Routes.classroomdetailView,
      arguments: ClassroomdetailViewArguments(
        classroom: {'id': topClassId, 'name': topClassName},
      ),
    );
  }

  @override
  void dispose() {
    _profileSub?.cancel();
    super.dispose();
  }
}
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Reusable Firebase Analytics wrapper.
///
/// Registered as a LazySingleton in `app.dart`. All logging is wrapped so an
/// analytics failure can never crash or block a user flow. Event names follow
/// the snake_case convention Firebase expects and stay <= 40 chars.
class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalytics get instance => _analytics;

  /// Navigation observer to attach to MaterialApp for automatic screen views.
  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future<void> _log(String name, [Map<String, Object>? params]) async {
    try {
      await _analytics.logEvent(name: name, parameters: params);
    } catch (e) {
      debugPrint('❌ [Analytics] log "$name" failed: $e');
    }
  }

  /// Associates subsequent events with a signed-in user (no PII — uid only).
  Future<void> setUser({required String uid, String? role}) async {
    try {
      await _analytics.setUserId(id: uid);
      if (role != null) {
        await _analytics.setUserProperty(name: 'role', value: role);
      }
    } catch (e) {
      debugPrint('❌ [Analytics] setUser failed: $e');
    }
  }

  Future<void> clearUser() async {
    try {
      await _analytics.setUserId(id: null);
    } catch (e) {
      debugPrint('❌ [Analytics] clearUser failed: $e');
    }
  }

  // ── Auth ──────────────────────────────────────────────────────────────
  Future<void> logSignUp({required String method, String? role}) =>
      _log('sign_up', {'method': method, if (role != null) 'role': role});

  Future<void> logLogin({required String method}) =>
      _log('login', {'method': method});

  Future<void> logLogout() => _log('logout');

  // ── Classroom ─────────────────────────────────────────────────────────
  Future<void> logClassCreate() => _log('class_create');

  Future<void> logClassJoin() => _log('class_join');

  // ── Content ───────────────────────────────────────────────────────────
  Future<void> logLessonCreate({String? classId}) =>
      _log('lesson_create', {if (classId != null) 'class_id': classId});

  Future<void> logQuizCreate({String? lessonId}) =>
      _log('quiz_create', {if (lessonId != null) 'lesson_id': lessonId});

  Future<void> logQuizSubmit({int? score, int? total}) => _log('quiz_submit', {
        if (score != null) 'score': score,
        if (total != null) 'total': total,
      });

  // ── Engagement ────────────────────────────────────────────────────────
  Future<void> logFavourite({required bool added, String? lessonId}) =>
      _log(added ? 'favourite_add' : 'favourite_remove', {
        if (lessonId != null) 'lesson_id': lessonId,
      });
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/models/lesson_data_model.dart';
import 'package:englify_app/services/analytics_service.dart';
import 'package:englify_app/services/firestore_keys.dart';

class CreateLessonService {
  final _lessons = FirebaseFirestore.instance.collection(FirestoreKeys.lessons);
  AnalyticsService get _analytics => locator<AnalyticsService>();

  // ✅ Auto lesson number - count existing lessons for this class then +1
  Future<int> _getNextLessonNumber(String classid) async {
    final snapshot = await _lessons
        .where(FirestoreKeys.classId, isEqualTo: classid)
        .get();
    return snapshot.docs.length + 1;
  }

  Future<String> createlesson({
    required String classid,
    required String teacherid,
    required String lessontitle,
    required String description,
    String? imageurl,
    String? contenturl,
  }) async {
    // Validation before write — reject empty title / missing references.
    if (classid.trim().isEmpty || teacherid.trim().isEmpty) {
      throw Exception("Lesson is missing its class or teacher reference");
    }
    if (lessontitle.trim().isEmpty) {
      throw Exception("Lesson title is required");
    }

    final lessonNumber = await _getNextLessonNumber(classid);

    final Map<String, dynamic> lessondata = {
      FirestoreKeys.classId: classid,
      FirestoreKeys.lessonTitle: lessontitle,
      FirestoreKeys.teacherId: teacherid,
      FirestoreKeys.lessonDescription: description,
      FirestoreKeys.createdAt: FieldValue.serverTimestamp(),
      'lessonNumber': lessonNumber, // ✅ Auto number
    };

    if (contenturl != null && contenturl.isNotEmpty) {
      lessondata[FirestoreKeys.lessonContentUrl] = contenturl;
    }

    if (imageurl != null && imageurl.isNotEmpty) {
      lessondata['imageUrl'] = imageurl;
    }

    final lessonref = await _lessons.add(lessondata);
    print("✅ Lesson #$lessonNumber created: ${lessonref.id}");

    await _analytics.logLessonCreate(classId: classid);

    return lessonref.id;
  }

  Stream<QuerySnapshot> getlessonforclass(String classid) {
    return _lessons
        .where(FirestoreKeys.classId, isEqualTo: classid)
        .orderBy(FirestoreKeys.createdAt, descending: false)
        .snapshots();
  }

  Future<List<LessonData>> getlesssonsdata(String classid) async {
    try {
      final snapshot = await _lessons
          .where(FirestoreKeys.classId, isEqualTo: classid)
          .orderBy(FirestoreKeys.createdAt, descending: false)
          .get();

      return snapshot.docs.map((doc) {
        return LessonData.fromFirestore(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    } catch (e) {
      print("error fetching lessons $e");
      return [];
    }
  }

  /// Loads one lesson by its document id.
  ///
  /// A favourite record only stores `lessonId` (plus a denormalised title,
  /// class name and image), so the favourites flow uses this to rehydrate the
  /// complete lesson — lessonNumber, description, contentUrl, teacherId —
  /// instead of rebuilding a partial [LessonData] from the favourite itself.
  ///
  /// Returns null when the lesson no longer exists, so callers can tell a
  /// deleted lesson apart from a load failure.
  Future<LessonData?> getLessonById(String lessonId) async {
    if (lessonId.trim().isEmpty) return null;
    try {
      final doc = await _lessons.doc(lessonId).get();
      if (!doc.exists) return null;
      return LessonData.fromFirestore(
        doc.id,
        doc.data() as Map<String, dynamic>,
      );
    } catch (e) {
      print('❌ Error loading lesson $lessonId: $e');
      return null;
    }
  }

  Future<void> deleteLesson(String lessonId) async {
    try {
      await _lessons.doc(lessonId).delete();
    } catch (e) {
      print('❌ Error deleting lesson: $e');
    }
  }
}
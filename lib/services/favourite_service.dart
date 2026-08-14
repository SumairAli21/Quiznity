import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/services/analytics_service.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/firestore_keys.dart';

class FavouriteService {
  final _firestore = FirebaseFirestore.instance;
  final _authservice = locator<AuthService>();
  AnalyticsService get _analytics => locator<AnalyticsService>();

  Future<bool> togglefavlesson({
    required String lessontitle,
    required String lessonid,
    required String classname,
    required String classid,
    required String? lessonimageurl,
  }) async {
    try {
      final user = await _authservice.currentuser;
      if (user == null) return false;

      final ref = _firestore
          .collection(FirestoreKeys.users)
          .doc(user.uid)
          .collection('favourites')
          .doc(lessonid);

      final doc = await ref.get();

      if (doc.exists) {
        await ref.delete(); // ← await add kiya
        await _analytics.logFavourite(added: false, lessonId: lessonid);
        return false;
      } else {
        await ref.set({
          'lessonId': lessonid,
          'lessonTitle': lessontitle,
          'classId': classid,
          'className': classname,
          'imageUrl': lessonimageurl,
          'addedAt': FieldValue.serverTimestamp(),
        });
        await _analytics.logFavourite(added: true, lessonId: lessonid);
        return true;
      }
    } catch (e) {
      print("failed to toggle favourite");
      return false;
    }
  }

  Future<bool> isfav(String lessonid) async {
    try {
      final user = await _authservice.currentuser;
      if (user == null) return false;

      final doc = await _firestore
          .collection(FirestoreKeys.users)
          .doc(user.uid)
          .collection('favourites')
          .doc(lessonid)
          .get();

      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getfav() async {
    try {
      final user = await _authservice.currentuser;
      if (user == null) return [];

      final snapshot = await _firestore
          .collection(FirestoreKeys.users)
          .doc(user.uid)
          .collection('favourites')
          .orderBy('addedAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('failed to get favourites');
      return [];
    }
  }
}
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/models/classdata_model.dart';
import 'package:englify_app/services/analytics_service.dart';

class classroomservice {
  final _classes = FirebaseFirestore.instance.collection("classes");
  AnalyticsService get _analytics => locator<AnalyticsService>();

  //========================
  // Generate Class Code
  //========================
  String _generateclasscode() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    const numbers = '0123456789';

    final rand = Random();

    List<String> code = [];

    for (int i = 0; i < 2; i++) {
      code.add(numbers[rand.nextInt(numbers.length)]);
    }

    for (int i = 0; i < 4; i++) {
      code.add(letters[rand.nextInt(letters.length)]);
    }

    code.shuffle(rand);

    return code.join();
  }

  //========================
  // Create Class
  //========================
  Future<String> createclass({
    required String classname,
    required String teacher_id,
    required int maxstudents,
    String? imageUrl,
  }) async {
    if (maxstudents < 1 || maxstudents > 59) {
      throw Exception("Students must be between 1 and 59");
    }
    // Validation before write — reject empty class name / missing teacher.
    if (classname.trim().isEmpty) {
      throw Exception("Class name is required");
    }
    if (teacher_id.trim().isEmpty) {
      throw Exception("Missing teacher id");
    }

    final code = _generateclasscode();

    final classRef = await _classes.add({
      "name": classname,

      "classCode": code,

      "teacherId": teacher_id,

      "maxStudents": maxstudents,

      // joined students only
      "currentStudentCount": 0,

      "createdAt": FieldValue.serverTimestamp(),

      if (imageUrl != null) "imageUrl": imageUrl,
    });

    // Teacher member inside class
    await classRef.collection("members").doc(teacher_id).set({
      "userId": teacher_id,

      "role": "teacher",

      "joinedAt": FieldValue.serverTimestamp(),
    });

    print("Class created successfully");

    await _analytics.logClassCreate();

    return code;
  }

  //========================
  // Join Class
  //========================
  Future<String?> joinclass({
    required String classcode,
    required String studentid,
  }) async {
    try {
      final result = await _classes
          .where("classCode", isEqualTo: classcode)
          .get();

      if (result.docs.isEmpty) {
        return "Invalid class code";
      }

      final classDoc = result.docs.first;
      final classData = classDoc.data();

      final maxStudents = classData["maxStudents"];
      final currentCount = classData["currentStudentCount"];

      if (currentCount >= maxStudents) {
        return "Class is full";
      }

      final memberRef = classDoc.reference.collection("members").doc(studentid);

      final existing = await memberRef.get();

      if (existing.exists) {
        return "Already joined this class";
      }

      // ✅ IMPORTANT: batch write (safe + fast)
      final batch = FirebaseFirestore.instance.batch();

      batch.set(memberRef, {
        "userId": studentid,
        "role": "student",
        "joinedAt": FieldValue.serverTimestamp(),
      });

      batch.update(classDoc.reference, {
        "currentStudentCount": FieldValue.increment(1),
      });

      await batch.commit();

      print("✅ Student joined class");

      await _analytics.logClassJoin();

      return null;
    } catch (e) {
      print("❌ JOIN ERROR: $e");
      return "Something went wrong";
    }
  }

  //========================
  // Check Student Joined Any
  //========================
  Future<bool> hasStudentJoinedAnyClass(String studentId) async {
    try {
      final classes = await _classes.get();

      for (var doc in classes.docs) {
        final member = await doc.reference
            .collection("members")
            .doc(studentId)
            .get();

        if (member.exists) {
          return true;
        }
      }

      return false;
    } catch (e) {
      print(e);

      return false;
    }
  }

  //========================
  // Teacher Classes
  //========================
  Stream<QuerySnapshot> getTeacherClasses(String teacherId) {
    return _classes.where("teacherId", isEqualTo: teacherId).snapshots();
  }

  //========================
  // Student Classes
  //========================
  Future<List<ClassData>> getStudentClassesData(String studentId) async {
    try {
      List<ClassData> classes = [];

      final allClasses = await _classes.get();

      for (var doc in allClasses.docs) {
        final member = await doc.reference
            .collection("members")
            .doc(studentId)
            .get();

        if (member.exists) {
          classes.add(ClassData.fromFirestore(doc.id, doc.data()));
        }
      }

      return classes;
    } catch (e) {
      print("Error loading classes $e");

      return [];
    }
  }

  //========================
  // Single Class
  //========================
  Future<ClassData?> getClassById(String classId) async {
    try {
      final doc = await _classes.doc(classId).get();

      if (doc.exists) {
        return ClassData.fromFirestore(doc.id, doc.data()!);
      }

      return null;
    } catch (e) {
      print(e);

      return null;
    }
  }

  //========================
  // Total Members Count
  //========================
  Future<int> getClassMemberCount(String classId) async {
    final snapshot = await _classes.doc(classId).collection("members").get();

    return snapshot.docs.length;
  }

  //========================
  // Get Members Stream
  //========================
  Stream<QuerySnapshot> getClassMembers(String classId) {
    return _classes.doc(classId).collection("members").snapshots();
  }
}

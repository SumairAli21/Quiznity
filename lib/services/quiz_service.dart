import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/models/quiz_model.dart';
import 'package:englify_app/services/analytics_service.dart';

class QuizService {
  final _firestore = FirebaseFirestore.instance;
  AnalyticsService get _analytics => locator<AnalyticsService>();

  // ✅ CHECK EXISTING QUIZ
  Future<bool> hasQuizForLesson({
    required String classId,
    required String lessonId,
  }) async {
    final snapshot = await _firestore
        .collection('classes')
        .doc(classId)
        .collection('lessons')
        .doc(lessonId)
        .collection('quizzes')
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  // ✅ CREATE QUIZ (PROTECTED)
  Future<void> createQuiz(QuizModel quiz) async {
    final exists = await hasQuizForLesson(
      classId: quiz.classId,
      lessonId: quiz.lessonId,
    );

    if (exists) {
      throw Exception("Quiz already exists");
    }

    // Validation before write — a quiz must have at least one question.
    if (quiz.classId.trim().isEmpty || quiz.lessonId.trim().isEmpty) {
      throw Exception("Quiz is missing its class or lesson reference");
    }
    if (quiz.questions.isEmpty) {
      throw Exception("A quiz must have at least one question");
    }

    await _firestore
        .collection('classes')
        .doc(quiz.classId)
        .collection('lessons')
        .doc(quiz.lessonId)
        .collection('quizzes')
        .add(quiz.toMap());

    await _analytics.logQuizCreate(lessonId: quiz.lessonId);
  }

  // ✅ GET QUIZ (Student)
  Future<List<QuizQuestion>> getQuizQuestions({
    required String classId,
    required String lessonId,
  }) async {
    final snapshot = await _firestore
        .collection('classes')
        .doc(classId)
        .collection('lessons')
        .doc(lessonId)
        .collection('quizzes')
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return [];

    final data = snapshot.docs.first.data();

    final questions = data['questions'] as List<dynamic>;

    return questions
        .map((q) => QuizQuestion.fromMap(q))
        .toList();
  }
}
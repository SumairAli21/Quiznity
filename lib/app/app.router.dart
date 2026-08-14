// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:englify_app/models/lesson_data_model.dart' as _i42;
import 'package:englify_app/models/quiz_attempt_model.dart' as _i44;
import 'package:englify_app/services/tracker_service.dart' as _i43;
import 'package:englify_app/UI/views/auth/auth_view.dart' as _i5;
import 'package:englify_app/UI/views/changepassword/changepassword_view.dart'
    as _i34;
import 'package:englify_app/UI/views/classroomcode/classroom_view.dart' as _i12;
import 'package:englify_app/UI/views/email_verification/email_verification_view.dart'
    as _i8;
import 'package:englify_app/UI/views/feedback/feedback_view.dart' as _i35;
import 'package:englify_app/UI/views/forgatepassword/forpass_view.dart' as _i13;
import 'package:englify_app/UI/views/login/login_view.dart' as _i7;
import 'package:englify_app/UI/views/onbording/onbording_view.dart' as _i3;
import 'package:englify_app/UI/views/personalization/personalization_view.dart'
    as _i10;
import 'package:englify_app/UI/views/privecy&policy/privecyandpolicy_view.dart'
    as _i18;
import 'package:englify_app/UI/views/Role_selection/role_selection.dart' as _i4;
import 'package:englify_app/UI/views/rules/rules_view.dart' as _i36;
import 'package:englify_app/UI/views/signup/signup_email_view.dart' as _i6;
import 'package:englify_app/UI/views/signup/signup_password_view.dart' as _i9;
import 'package:englify_app/UI/views/splach/splach_view.dart' as _i2;
import 'package:englify_app/UI/views/student_flow/bottom_navigation/bottom_navi_view.dart'
    as _i17;
import 'package:englify_app/UI/views/student_flow/profile/std_profile_view.dart'
    as _i33;
import 'package:englify_app/UI/views/student_flow/quiz_attempt/quiz_attempt_view.dart'
    as _i32;
import 'package:englify_app/UI/views/student_flow/select_lesson/std_select_lesson_view.dart'
    as _i31;
import 'package:englify_app/UI/views/student_flow/std_lesson_detail/std_lessondetail_view.dart'
    as _i30;
import 'package:englify_app/UI/views/student_flow/studenhome/student_home_view.dart'
    as _i14;
import 'package:englify_app/UI/views/student_flow/student_classroom_detail/student_classroom_detai_view.dart'
    as _i29;
import 'package:englify_app/UI/views/student_flow/student_dashboard/student_dashboard_view.dart'
    as _i15;
import 'package:englify_app/UI/views/student_flow/student_fav/student_fav_view.dart'
    as _i16;
import 'package:englify_app/UI/views/teacher_flow/classroom_create/classroom_create_view.dart'
    as _i20;
import 'package:englify_app/UI/views/teacher_flow/classroom_detail/classroomdetail_view.dart'
    as _i25;
import 'package:englify_app/UI/views/teacher_flow/create_lessons/create_lesson_view.dart'
    as _i26;
import 'package:englify_app/UI/views/teacher_flow/create_quiz/create_quiz_view.dart'
    as _i28;
import 'package:englify_app/UI/views/teacher_flow/lesson_detail/lesson_detail_view.dart'
    as _i27;
import 'package:englify_app/UI/views/teacher_flow/std_detail/std_details_view.dart'
    as _i38;
import 'package:englify_app/UI/views/teacher_flow/std_list/std_list_view.dart'
    as _i37;
import 'package:englify_app/UI/views/teacher_flow/teacher_bottom_tabs/teacher_bottom_tab_view.dart'
    as _i24;
import 'package:englify_app/UI/views/teacher_flow/teacher_dashboard/teacher_dashboard_view.dart'
    as _i21;
import 'package:englify_app/UI/views/teacher_flow/teacher_home/teacher_home_view.dart'
    as _i11;
import 'package:englify_app/UI/views/teacher_flow/teacher_profile/teacher_profile_view.dart'
    as _i23;
import 'package:englify_app/UI/views/teacher_flow/teacher_tracker/quiz_attempt_detail_view.dart'
    as _i40;
import 'package:englify_app/UI/views/teacher_flow/teacher_tracker/student_quiz_record_view.dart'
    as _i39;
import 'package:englify_app/UI/views/teacher_flow/teacher_tracker/teacher_tracker_view.dart'
    as _i22;
import 'package:englify_app/UI/views/terms&condition/terms&cond_view.dart'
    as _i19;
import 'package:flutter/material.dart' as _i41;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i45;

class Routes {
  static const splachView = '/';

  static const onbordingView = '/onbording-view';

  static const roleSelection = '/role-selection';

  static const authView = '/auth-view';

  static const signupemailview = '/Signupemailview';

  static const loginView = '/login-view';

  static const emailVerificationView = '/email-verification-view';

  static const signupPasswordView = '/signup-password-view';

  static const personalizationView = '/personalization-view';

  static const teacherHomeView = '/teacher-home-view';

  static const classroomcodeView = '/classroomcode-view';

  static const forgotPasswordView = '/forgot-password-view';

  static const studentHomeView = '/student-home-view';

  static const studentDashboardView = '/student-dashboard-view';

  static const studentFavView = '/student-fav-view';

  static const bottomNaviView = '/bottom-navi-view';

  static const privecyandpolicyView = '/privecyandpolicy-view';

  static const termsandcondView = '/termsandcond-view';

  static const classroomCreateView = '/classroom-create-view';

  static const teacherDashboardView = '/teacher-dashboard-view';

  static const teacherTrackerView = '/teacher-tracker-view';

  static const teacherProfileView = '/teacher-profile-view';

  static const teacherBottomTabView = '/teacher-bottom-tab-view';

  static const classroomdetailView = '/classroomdetail-view';

  static const createLessonView = '/create-lesson-view';

  static const lessonDetailView = '/lesson-detail-view';

  static const createQuizView = '/create-quiz-view';

  static const studentClassroomDetaiView = '/student-classroom-detai-view';

  static const stdLessondetailView = '/std-lessondetail-view';

  static const stdSelectLessonView = '/std-select-lesson-view';

  static const quizAttemptView = '/quiz-attempt-view';

  static const stdProfileView = '/std-profile-view';

  static const changePasswordView = '/change-password-view';

  static const feedbackView = '/feedback-view';

  static const rulesView = '/rules-view';

  static const studentsListView = '/students-list-view';

  static const studentDetailView = '/student-detail-view';

  static const studentQuizRecordView = '/student-quiz-record-view';

  static const quizAttemptDetailView = '/quiz-attempt-detail-view';

  static const all = <String>{
    splachView,
    onbordingView,
    roleSelection,
    authView,
    signupemailview,
    loginView,
    emailVerificationView,
    signupPasswordView,
    personalizationView,
    teacherHomeView,
    classroomcodeView,
    forgotPasswordView,
    studentHomeView,
    studentDashboardView,
    studentFavView,
    bottomNaviView,
    privecyandpolicyView,
    termsandcondView,
    classroomCreateView,
    teacherDashboardView,
    teacherTrackerView,
    teacherProfileView,
    teacherBottomTabView,
    classroomdetailView,
    createLessonView,
    lessonDetailView,
    createQuizView,
    studentClassroomDetaiView,
    stdLessondetailView,
    stdSelectLessonView,
    quizAttemptView,
    stdProfileView,
    changePasswordView,
    feedbackView,
    rulesView,
    studentsListView,
    studentDetailView,
    studentQuizRecordView,
    quizAttemptDetailView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(Routes.splachView, page: _i2.SplachView),
    _i1.RouteDef(Routes.onbordingView, page: _i3.OnbordingView),
    _i1.RouteDef(Routes.roleSelection, page: _i4.RoleSelection),
    _i1.RouteDef(Routes.authView, page: _i5.AuthView),
    _i1.RouteDef(Routes.signupemailview, page: _i6.Signupemailview),
    _i1.RouteDef(Routes.loginView, page: _i7.LoginView),
    _i1.RouteDef(Routes.emailVerificationView, page: _i8.EmailVerificationView),
    _i1.RouteDef(Routes.signupPasswordView, page: _i9.SignupPasswordView),
    _i1.RouteDef(Routes.personalizationView, page: _i10.PersonalizationView),
    _i1.RouteDef(Routes.teacherHomeView, page: _i11.TeacherHomeView),
    _i1.RouteDef(Routes.classroomcodeView, page: _i12.ClassroomcodeView),
    _i1.RouteDef(Routes.forgotPasswordView, page: _i13.ForgotPasswordView),
    _i1.RouteDef(Routes.studentHomeView, page: _i14.StudentHomeView),
    _i1.RouteDef(Routes.studentDashboardView, page: _i15.StudentDashboardView),
    _i1.RouteDef(Routes.studentFavView, page: _i16.StudentFavView),
    _i1.RouteDef(Routes.bottomNaviView, page: _i17.BottomNaviView),
    _i1.RouteDef(Routes.privecyandpolicyView, page: _i18.PrivecyandpolicyView),
    _i1.RouteDef(Routes.termsandcondView, page: _i19.TermsandcondView),
    _i1.RouteDef(Routes.classroomCreateView, page: _i20.ClassroomCreateView),
    _i1.RouteDef(Routes.teacherDashboardView, page: _i21.TeacherDashboardView),
    _i1.RouteDef(Routes.teacherTrackerView, page: _i22.TeacherTrackerView),
    _i1.RouteDef(Routes.teacherProfileView, page: _i23.TeacherProfileView),
    _i1.RouteDef(Routes.teacherBottomTabView, page: _i24.TeacherBottomTabView),
    _i1.RouteDef(Routes.classroomdetailView, page: _i25.ClassroomdetailView),
    _i1.RouteDef(Routes.createLessonView, page: _i26.CreateLessonView),
    _i1.RouteDef(Routes.lessonDetailView, page: _i27.LessonDetailView),
    _i1.RouteDef(Routes.createQuizView, page: _i28.CreateQuizView),
    _i1.RouteDef(
      Routes.studentClassroomDetaiView,
      page: _i29.StudentClassroomDetaiView,
    ),
    _i1.RouteDef(Routes.stdLessondetailView, page: _i30.StdLessondetailView),
    _i1.RouteDef(Routes.stdSelectLessonView, page: _i31.StdSelectLessonView),
    _i1.RouteDef(Routes.quizAttemptView, page: _i32.QuizAttemptView),
    _i1.RouteDef(Routes.stdProfileView, page: _i33.StdProfileView),
    _i1.RouteDef(Routes.changePasswordView, page: _i34.ChangePasswordView),
    _i1.RouteDef(Routes.feedbackView, page: _i35.FeedbackView),
    _i1.RouteDef(Routes.rulesView, page: _i36.RulesView),
    _i1.RouteDef(Routes.studentsListView, page: _i37.StudentsListView),
    _i1.RouteDef(Routes.studentDetailView, page: _i38.StudentDetailView),
    _i1.RouteDef(
      Routes.studentQuizRecordView,
      page: _i39.StudentQuizRecordView,
    ),
    _i1.RouteDef(
      Routes.quizAttemptDetailView,
      page: _i40.QuizAttemptDetailView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplachView: (data) {
      final args = data.getArgs<SplachViewArguments>(
        orElse: () => const SplachViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.SplachView(key: args.key),
        settings: data,
      );
    },
    _i3.OnbordingView: (data) {
      final args = data.getArgs<OnbordingViewArguments>(
        orElse: () => const OnbordingViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.OnbordingView(key: args.key),
        settings: data,
      );
    },
    _i4.RoleSelection: (data) {
      final args = data.getArgs<RoleSelectionArguments>(
        orElse: () => const RoleSelectionArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.RoleSelection(key: args.key),
        settings: data,
      );
    },
    _i5.AuthView: (data) {
      final args = data.getArgs<AuthViewArguments>(
        orElse: () => const AuthViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.AuthView(key: args.key),
        settings: data,
      );
    },
    _i6.Signupemailview: (data) {
      final args = data.getArgs<SignupemailviewArguments>(
        orElse: () => const SignupemailviewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.Signupemailview(key: args.key),
        settings: data,
      );
    },
    _i7.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.LoginView(key: args.key),
        settings: data,
      );
    },
    _i8.EmailVerificationView: (data) {
      final args = data.getArgs<EmailVerificationViewArguments>(
        orElse: () => const EmailVerificationViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.EmailVerificationView(key: args.key),
        settings: data,
      );
    },
    _i9.SignupPasswordView: (data) {
      final args = data.getArgs<SignupPasswordViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i9.SignupPasswordView(key: args.key, email: args.email),
        settings: data,
      );
    },
    _i10.PersonalizationView: (data) {
      final args = data.getArgs<PersonalizationViewArguments>(
        orElse: () => const PersonalizationViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.PersonalizationView(key: args.key),
        settings: data,
      );
    },
    _i11.TeacherHomeView: (data) {
      final args = data.getArgs<TeacherHomeViewArguments>(
        orElse: () => const TeacherHomeViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.TeacherHomeView(key: args.key),
        settings: data,
      );
    },
    _i12.ClassroomcodeView: (data) {
      final args = data.getArgs<ClassroomcodeViewArguments>(
        orElse: () => const ClassroomcodeViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.ClassroomcodeView(key: args.key),
        settings: data,
      );
    },
    _i13.ForgotPasswordView: (data) {
      final args = data.getArgs<ForgotPasswordViewArguments>(
        orElse: () => const ForgotPasswordViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.ForgotPasswordView(key: args.key),
        settings: data,
      );
    },
    _i14.StudentHomeView: (data) {
      final args = data.getArgs<StudentHomeViewArguments>(
        orElse: () => const StudentHomeViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.StudentHomeView(key: args.key),
        settings: data,
      );
    },
    _i15.StudentDashboardView: (data) {
      final args = data.getArgs<StudentDashboardViewArguments>(
        orElse: () => const StudentDashboardViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.StudentDashboardView(key: args.key),
        settings: data,
      );
    },
    _i16.StudentFavView: (data) {
      final args = data.getArgs<StudentFavViewArguments>(
        orElse: () => const StudentFavViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.StudentFavView(key: args.key),
        settings: data,
      );
    },
    _i17.BottomNaviView: (data) {
      final args = data.getArgs<BottomNaviViewArguments>(
        orElse: () => const BottomNaviViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i17.BottomNaviView(key: args.key),
        settings: data,
      );
    },
    _i18.PrivecyandpolicyView: (data) {
      final args = data.getArgs<PrivecyandpolicyViewArguments>(
        orElse: () => const PrivecyandpolicyViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i18.PrivecyandpolicyView(key: args.key),
        settings: data,
      );
    },
    _i19.TermsandcondView: (data) {
      final args = data.getArgs<TermsandcondViewArguments>(
        orElse: () => const TermsandcondViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.TermsandcondView(key: args.key),
        settings: data,
      );
    },
    _i20.ClassroomCreateView: (data) {
      final args = data.getArgs<ClassroomCreateViewArguments>(
        orElse: () => const ClassroomCreateViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i20.ClassroomCreateView(key: args.key),
        settings: data,
      );
    },
    _i21.TeacherDashboardView: (data) {
      final args = data.getArgs<TeacherDashboardViewArguments>(
        orElse: () => const TeacherDashboardViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i21.TeacherDashboardView(key: args.key),
        settings: data,
      );
    },
    _i22.TeacherTrackerView: (data) {
      final args = data.getArgs<TeacherTrackerViewArguments>(
        orElse: () => const TeacherTrackerViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i22.TeacherTrackerView(key: args.key),
        settings: data,
      );
    },
    _i23.TeacherProfileView: (data) {
      final args = data.getArgs<TeacherProfileViewArguments>(
        orElse: () => const TeacherProfileViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i23.TeacherProfileView(key: args.key),
        settings: data,
      );
    },
    _i24.TeacherBottomTabView: (data) {
      final args = data.getArgs<TeacherBottomTabViewArguments>(
        orElse: () => const TeacherBottomTabViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i24.TeacherBottomTabView(key: args.key),
        settings: data,
      );
    },
    _i25.ClassroomdetailView: (data) {
      final args = data.getArgs<ClassroomdetailViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i25.ClassroomdetailView(key: args.key, classroom: args.classroom),
        settings: data,
      );
    },
    _i26.CreateLessonView: (data) {
      final args = data.getArgs<CreateLessonViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i26.CreateLessonView(key: args.key, classid: args.classid),
        settings: data,
      );
    },
    _i27.LessonDetailView: (data) {
      final args = data.getArgs<LessonDetailViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i27.LessonDetailView(
          key: args.key,
          classroom: args.classroom,
          lessons: args.lessons,
        ),
        settings: data,
      );
    },
    _i28.CreateQuizView: (data) {
      final args = data.getArgs<CreateQuizViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i28.CreateQuizView(
          key: args.key,
          classid: args.classid,
          lessonid: args.lessonid,
          lessontitle: args.lessontitle,
        ),
        settings: data,
      );
    },
    _i29.StudentClassroomDetaiView: (data) {
      final args = data.getArgs<StudentClassroomDetaiViewArguments>(
        nullOk: false,
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i29.StudentClassroomDetaiView(
          key: args.key,
          classroom: args.classroom,
        ),
        settings: data,
      );
    },
    _i30.StdLessondetailView: (data) {
      final args = data.getArgs<StdLessondetailViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i30.StdLessondetailView(
          key: args.key,
          lesson: args.lesson,
          classroom: args.classroom,
        ),
        settings: data,
      );
    },
    _i31.StdSelectLessonView: (data) {
      final args = data.getArgs<StdSelectLessonViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i31.StdSelectLessonView(
          key: args.key,
          lesson: args.lesson,
          classroom: args.classroom,
        ),
        settings: data,
      );
    },
    _i32.QuizAttemptView: (data) {
      final args = data.getArgs<QuizAttemptViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i32.QuizAttemptView(
          key: args.key,
          classId: args.classId,
          lessonId: args.lessonId,
          lessonTitle: args.lessonTitle,
        ),
        settings: data,
      );
    },
    _i33.StdProfileView: (data) {
      final args = data.getArgs<StdProfileViewArguments>(
        orElse: () => const StdProfileViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i33.StdProfileView(key: args.key),
        settings: data,
      );
    },
    _i34.ChangePasswordView: (data) {
      final args = data.getArgs<ChangePasswordViewArguments>(
        orElse: () => const ChangePasswordViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i34.ChangePasswordView(key: args.key),
        settings: data,
      );
    },
    _i35.FeedbackView: (data) {
      final args = data.getArgs<FeedbackViewArguments>(
        orElse: () => const FeedbackViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i35.FeedbackView(key: args.key),
        settings: data,
      );
    },
    _i36.RulesView: (data) {
      final args = data.getArgs<RulesViewArguments>(
        orElse: () => const RulesViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i36.RulesView(key: args.key),
        settings: data,
      );
    },
    _i37.StudentsListView: (data) {
      final args = data.getArgs<StudentsListViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i37.StudentsListView(key: args.key, teacherId: args.teacherId),
        settings: data,
      );
    },
    _i38.StudentDetailView: (data) {
      final args = data.getArgs<StudentDetailViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i38.StudentDetailView(
          key: args.key,
          teacherId: args.teacherId,
          studentId: args.studentId,
        ),
        settings: data,
      );
    },
    _i39.StudentQuizRecordView: (data) {
      final args = data.getArgs<StudentQuizRecordViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i39.StudentQuizRecordView(key: args.key, summary: args.summary),
        settings: data,
      );
    },
    _i40.QuizAttemptDetailView: (data) {
      final args = data.getArgs<QuizAttemptDetailViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i40.QuizAttemptDetailView(key: args.key, attempt: args.attempt),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class SplachViewArguments {
  const SplachViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SplachViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class OnbordingViewArguments {
  const OnbordingViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant OnbordingViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class RoleSelectionArguments {
  const RoleSelectionArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant RoleSelectionArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class AuthViewArguments {
  const AuthViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant AuthViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SignupemailviewArguments {
  const SignupemailviewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SignupemailviewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant LoginViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class EmailVerificationViewArguments {
  const EmailVerificationViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant EmailVerificationViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SignupPasswordViewArguments {
  const SignupPasswordViewArguments({this.key, required this.email});

  final _i41.Key? key;

  final String email;

  @override
  String toString() {
    return '{"key": "$key", "email": "$email"}';
  }

  @override
  bool operator ==(covariant SignupPasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.email == email;
  }

  @override
  int get hashCode {
    return key.hashCode ^ email.hashCode;
  }
}

class PersonalizationViewArguments {
  const PersonalizationViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant PersonalizationViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TeacherHomeViewArguments {
  const TeacherHomeViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TeacherHomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ClassroomcodeViewArguments {
  const ClassroomcodeViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ClassroomcodeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ForgotPasswordViewArguments {
  const ForgotPasswordViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ForgotPasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class StudentHomeViewArguments {
  const StudentHomeViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant StudentHomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class StudentDashboardViewArguments {
  const StudentDashboardViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant StudentDashboardViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class StudentFavViewArguments {
  const StudentFavViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant StudentFavViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class BottomNaviViewArguments {
  const BottomNaviViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant BottomNaviViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class PrivecyandpolicyViewArguments {
  const PrivecyandpolicyViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant PrivecyandpolicyViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TermsandcondViewArguments {
  const TermsandcondViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TermsandcondViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ClassroomCreateViewArguments {
  const ClassroomCreateViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ClassroomCreateViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TeacherDashboardViewArguments {
  const TeacherDashboardViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TeacherDashboardViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TeacherTrackerViewArguments {
  const TeacherTrackerViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TeacherTrackerViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TeacherProfileViewArguments {
  const TeacherProfileViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TeacherProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TeacherBottomTabViewArguments {
  const TeacherBottomTabViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TeacherBottomTabViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ClassroomdetailViewArguments {
  const ClassroomdetailViewArguments({this.key, required this.classroom});

  final _i41.Key? key;

  final Map<String, dynamic> classroom;

  @override
  String toString() {
    return '{"key": "$key", "classroom": "$classroom"}';
  }

  @override
  bool operator ==(covariant ClassroomdetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.classroom == classroom;
  }

  @override
  int get hashCode {
    return key.hashCode ^ classroom.hashCode;
  }
}

class CreateLessonViewArguments {
  const CreateLessonViewArguments({this.key, required this.classid});

  final _i41.Key? key;

  final String classid;

  @override
  String toString() {
    return '{"key": "$key", "classid": "$classid"}';
  }

  @override
  bool operator ==(covariant CreateLessonViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.classid == classid;
  }

  @override
  int get hashCode {
    return key.hashCode ^ classid.hashCode;
  }
}

class LessonDetailViewArguments {
  const LessonDetailViewArguments({
    this.key,
    required this.classroom,
    required this.lessons,
  });

  final _i41.Key? key;

  final Map<String, dynamic> classroom;

  final _i42.LessonData lessons;

  @override
  String toString() {
    return '{"key": "$key", "classroom": "$classroom", "lessons": "$lessons"}';
  }

  @override
  bool operator ==(covariant LessonDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.classroom == classroom &&
        other.lessons == lessons;
  }

  @override
  int get hashCode {
    return key.hashCode ^ classroom.hashCode ^ lessons.hashCode;
  }
}

class CreateQuizViewArguments {
  const CreateQuizViewArguments({
    this.key,
    required this.classid,
    required this.lessonid,
    required this.lessontitle,
  });

  final _i41.Key? key;

  final String classid;

  final String lessonid;

  final String lessontitle;

  @override
  String toString() {
    return '{"key": "$key", "classid": "$classid", "lessonid": "$lessonid", "lessontitle": "$lessontitle"}';
  }

  @override
  bool operator ==(covariant CreateQuizViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.classid == classid &&
        other.lessonid == lessonid &&
        other.lessontitle == lessontitle;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        classid.hashCode ^
        lessonid.hashCode ^
        lessontitle.hashCode;
  }
}

class StudentClassroomDetaiViewArguments {
  const StudentClassroomDetaiViewArguments({this.key, required this.classroom});

  final _i41.Key? key;

  final Map<String, dynamic> classroom;

  @override
  String toString() {
    return '{"key": "$key", "classroom": "$classroom"}';
  }

  @override
  bool operator ==(covariant StudentClassroomDetaiViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.classroom == classroom;
  }

  @override
  int get hashCode {
    return key.hashCode ^ classroom.hashCode;
  }
}

class StdLessondetailViewArguments {
  const StdLessondetailViewArguments({
    this.key,
    required this.lesson,
    required this.classroom,
  });

  final _i41.Key? key;

  final _i42.LessonData lesson;

  final Map<String, dynamic> classroom;

  @override
  String toString() {
    return '{"key": "$key", "lesson": "$lesson", "classroom": "$classroom"}';
  }

  @override
  bool operator ==(covariant StdLessondetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.lesson == lesson &&
        other.classroom == classroom;
  }

  @override
  int get hashCode {
    return key.hashCode ^ lesson.hashCode ^ classroom.hashCode;
  }
}

class StdSelectLessonViewArguments {
  const StdSelectLessonViewArguments({
    this.key,
    required this.lesson,
    required this.classroom,
  });

  final _i41.Key? key;

  final _i42.LessonData lesson;

  final Map<String, dynamic> classroom;

  @override
  String toString() {
    return '{"key": "$key", "lesson": "$lesson", "classroom": "$classroom"}';
  }

  @override
  bool operator ==(covariant StdSelectLessonViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.lesson == lesson &&
        other.classroom == classroom;
  }

  @override
  int get hashCode {
    return key.hashCode ^ lesson.hashCode ^ classroom.hashCode;
  }
}

class QuizAttemptViewArguments {
  const QuizAttemptViewArguments({
    this.key,
    required this.classId,
    required this.lessonId,
    required this.lessonTitle,
  });

  final _i41.Key? key;

  final String classId;

  final String lessonId;

  final String lessonTitle;

  @override
  String toString() {
    return '{"key": "$key", "classId": "$classId", "lessonId": "$lessonId", "lessonTitle": "$lessonTitle"}';
  }

  @override
  bool operator ==(covariant QuizAttemptViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.classId == classId &&
        other.lessonId == lessonId &&
        other.lessonTitle == lessonTitle;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        classId.hashCode ^
        lessonId.hashCode ^
        lessonTitle.hashCode;
  }
}

class StdProfileViewArguments {
  const StdProfileViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant StdProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ChangePasswordViewArguments {
  const ChangePasswordViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ChangePasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class FeedbackViewArguments {
  const FeedbackViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant FeedbackViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class RulesViewArguments {
  const RulesViewArguments({this.key});

  final _i41.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant RulesViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class StudentsListViewArguments {
  const StudentsListViewArguments({this.key, required this.teacherId});

  final _i41.Key? key;

  final String teacherId;

  @override
  String toString() {
    return '{"key": "$key", "teacherId": "$teacherId"}';
  }

  @override
  bool operator ==(covariant StudentsListViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.teacherId == teacherId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ teacherId.hashCode;
  }
}

class StudentDetailViewArguments {
  const StudentDetailViewArguments({
    this.key,
    required this.teacherId,
    required this.studentId,
  });

  final _i41.Key? key;

  final String teacherId;

  final String studentId;

  @override
  String toString() {
    return '{"key": "$key", "teacherId": "$teacherId", "studentId": "$studentId"}';
  }

  @override
  bool operator ==(covariant StudentDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.teacherId == teacherId &&
        other.studentId == studentId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ teacherId.hashCode ^ studentId.hashCode;
  }
}

class StudentQuizRecordViewArguments {
  const StudentQuizRecordViewArguments({this.key, required this.summary});

  final _i41.Key? key;

  final _i43.StudentTrackerSummary summary;

  @override
  String toString() {
    return '{"key": "$key", "summary": "$summary"}';
  }

  @override
  bool operator ==(covariant StudentQuizRecordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.summary == summary;
  }

  @override
  int get hashCode {
    return key.hashCode ^ summary.hashCode;
  }
}

class QuizAttemptDetailViewArguments {
  const QuizAttemptDetailViewArguments({this.key, required this.attempt});

  final _i41.Key? key;

  final _i44.QuizAttemptRecord attempt;

  @override
  String toString() {
    return '{"key": "$key", "attempt": "$attempt"}';
  }

  @override
  bool operator ==(covariant QuizAttemptDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.attempt == attempt;
  }

  @override
  int get hashCode {
    return key.hashCode ^ attempt.hashCode;
  }
}

extension NavigatorStateExtension on _i45.NavigationService {
  Future<dynamic> navigateToSplachView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.splachView,
      arguments: SplachViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToOnbordingView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.onbordingView,
      arguments: OnbordingViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToRoleSelection({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.roleSelection,
      arguments: RoleSelectionArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToAuthView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.authView,
      arguments: AuthViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToSignupemailview({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.signupemailview,
      arguments: SignupemailviewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToLoginView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.loginView,
      arguments: LoginViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToEmailVerificationView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.emailVerificationView,
      arguments: EmailVerificationViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToSignupPasswordView({
    _i41.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.signupPasswordView,
      arguments: SignupPasswordViewArguments(key: key, email: email),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToPersonalizationView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.personalizationView,
      arguments: PersonalizationViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToTeacherHomeView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.teacherHomeView,
      arguments: TeacherHomeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToClassroomcodeView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.classroomcodeView,
      arguments: ClassroomcodeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToForgotPasswordView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.forgotPasswordView,
      arguments: ForgotPasswordViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStudentHomeView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.studentHomeView,
      arguments: StudentHomeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStudentDashboardView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.studentDashboardView,
      arguments: StudentDashboardViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStudentFavView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.studentFavView,
      arguments: StudentFavViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToBottomNaviView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.bottomNaviView,
      arguments: BottomNaviViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToPrivecyandpolicyView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.privecyandpolicyView,
      arguments: PrivecyandpolicyViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToTermsandcondView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.termsandcondView,
      arguments: TermsandcondViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToClassroomCreateView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.classroomCreateView,
      arguments: ClassroomCreateViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToTeacherDashboardView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.teacherDashboardView,
      arguments: TeacherDashboardViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToTeacherTrackerView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.teacherTrackerView,
      arguments: TeacherTrackerViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToTeacherProfileView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.teacherProfileView,
      arguments: TeacherProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToTeacherBottomTabView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.teacherBottomTabView,
      arguments: TeacherBottomTabViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToClassroomdetailView({
    _i41.Key? key,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.classroomdetailView,
      arguments: ClassroomdetailViewArguments(key: key, classroom: classroom),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToCreateLessonView({
    _i41.Key? key,
    required String classid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.createLessonView,
      arguments: CreateLessonViewArguments(key: key, classid: classid),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToLessonDetailView({
    _i41.Key? key,
    required Map<String, dynamic> classroom,
    required _i42.LessonData lessons,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.lessonDetailView,
      arguments: LessonDetailViewArguments(
        key: key,
        classroom: classroom,
        lessons: lessons,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToCreateQuizView({
    _i41.Key? key,
    required String classid,
    required String lessonid,
    required String lessontitle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.createQuizView,
      arguments: CreateQuizViewArguments(
        key: key,
        classid: classid,
        lessonid: lessonid,
        lessontitle: lessontitle,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStudentClassroomDetaiView({
    _i41.Key? key,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.studentClassroomDetaiView,
      arguments: StudentClassroomDetaiViewArguments(
        key: key,
        classroom: classroom,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStdLessondetailView({
    _i41.Key? key,
    required _i42.LessonData lesson,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.stdLessondetailView,
      arguments: StdLessondetailViewArguments(
        key: key,
        lesson: lesson,
        classroom: classroom,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStdSelectLessonView({
    _i41.Key? key,
    required _i42.LessonData lesson,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.stdSelectLessonView,
      arguments: StdSelectLessonViewArguments(
        key: key,
        lesson: lesson,
        classroom: classroom,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToQuizAttemptView({
    _i41.Key? key,
    required String classId,
    required String lessonId,
    required String lessonTitle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.quizAttemptView,
      arguments: QuizAttemptViewArguments(
        key: key,
        classId: classId,
        lessonId: lessonId,
        lessonTitle: lessonTitle,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStdProfileView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.stdProfileView,
      arguments: StdProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToChangePasswordView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.changePasswordView,
      arguments: ChangePasswordViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToFeedbackView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.feedbackView,
      arguments: FeedbackViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToRulesView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.rulesView,
      arguments: RulesViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStudentsListView({
    _i41.Key? key,
    required String teacherId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.studentsListView,
      arguments: StudentsListViewArguments(key: key, teacherId: teacherId),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStudentDetailView({
    _i41.Key? key,
    required String teacherId,
    required String studentId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.studentDetailView,
      arguments: StudentDetailViewArguments(
        key: key,
        teacherId: teacherId,
        studentId: studentId,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStudentQuizRecordView({
    _i41.Key? key,
    required _i43.StudentTrackerSummary summary,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.studentQuizRecordView,
      arguments: StudentQuizRecordViewArguments(key: key, summary: summary),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToQuizAttemptDetailView({
    _i41.Key? key,
    required _i44.QuizAttemptRecord attempt,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.quizAttemptDetailView,
      arguments: QuizAttemptDetailViewArguments(key: key, attempt: attempt),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSplachView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.splachView,
      arguments: SplachViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithOnbordingView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.onbordingView,
      arguments: OnbordingViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithRoleSelection({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.roleSelection,
      arguments: RoleSelectionArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithAuthView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.authView,
      arguments: AuthViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSignupemailview({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.signupemailview,
      arguments: SignupemailviewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithLoginView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.loginView,
      arguments: LoginViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithEmailVerificationView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.emailVerificationView,
      arguments: EmailVerificationViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSignupPasswordView({
    _i41.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.signupPasswordView,
      arguments: SignupPasswordViewArguments(key: key, email: email),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithPersonalizationView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.personalizationView,
      arguments: PersonalizationViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithTeacherHomeView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.teacherHomeView,
      arguments: TeacherHomeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithClassroomcodeView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.classroomcodeView,
      arguments: ClassroomcodeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithForgotPasswordView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.forgotPasswordView,
      arguments: ForgotPasswordViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStudentHomeView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.studentHomeView,
      arguments: StudentHomeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStudentDashboardView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.studentDashboardView,
      arguments: StudentDashboardViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStudentFavView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.studentFavView,
      arguments: StudentFavViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithBottomNaviView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.bottomNaviView,
      arguments: BottomNaviViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithPrivecyandpolicyView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.privecyandpolicyView,
      arguments: PrivecyandpolicyViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithTermsandcondView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.termsandcondView,
      arguments: TermsandcondViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithClassroomCreateView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.classroomCreateView,
      arguments: ClassroomCreateViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithTeacherDashboardView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.teacherDashboardView,
      arguments: TeacherDashboardViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithTeacherTrackerView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.teacherTrackerView,
      arguments: TeacherTrackerViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithTeacherProfileView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.teacherProfileView,
      arguments: TeacherProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithTeacherBottomTabView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.teacherBottomTabView,
      arguments: TeacherBottomTabViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithClassroomdetailView({
    _i41.Key? key,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.classroomdetailView,
      arguments: ClassroomdetailViewArguments(key: key, classroom: classroom),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithCreateLessonView({
    _i41.Key? key,
    required String classid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.createLessonView,
      arguments: CreateLessonViewArguments(key: key, classid: classid),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithLessonDetailView({
    _i41.Key? key,
    required Map<String, dynamic> classroom,
    required _i42.LessonData lessons,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.lessonDetailView,
      arguments: LessonDetailViewArguments(
        key: key,
        classroom: classroom,
        lessons: lessons,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithCreateQuizView({
    _i41.Key? key,
    required String classid,
    required String lessonid,
    required String lessontitle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.createQuizView,
      arguments: CreateQuizViewArguments(
        key: key,
        classid: classid,
        lessonid: lessonid,
        lessontitle: lessontitle,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStudentClassroomDetaiView({
    _i41.Key? key,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.studentClassroomDetaiView,
      arguments: StudentClassroomDetaiViewArguments(
        key: key,
        classroom: classroom,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStdLessondetailView({
    _i41.Key? key,
    required _i42.LessonData lesson,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.stdLessondetailView,
      arguments: StdLessondetailViewArguments(
        key: key,
        lesson: lesson,
        classroom: classroom,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStdSelectLessonView({
    _i41.Key? key,
    required _i42.LessonData lesson,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.stdSelectLessonView,
      arguments: StdSelectLessonViewArguments(
        key: key,
        lesson: lesson,
        classroom: classroom,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithQuizAttemptView({
    _i41.Key? key,
    required String classId,
    required String lessonId,
    required String lessonTitle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.quizAttemptView,
      arguments: QuizAttemptViewArguments(
        key: key,
        classId: classId,
        lessonId: lessonId,
        lessonTitle: lessonTitle,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStdProfileView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.stdProfileView,
      arguments: StdProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithChangePasswordView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.changePasswordView,
      arguments: ChangePasswordViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithFeedbackView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.feedbackView,
      arguments: FeedbackViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithRulesView({
    _i41.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.rulesView,
      arguments: RulesViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStudentsListView({
    _i41.Key? key,
    required String teacherId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.studentsListView,
      arguments: StudentsListViewArguments(key: key, teacherId: teacherId),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStudentDetailView({
    _i41.Key? key,
    required String teacherId,
    required String studentId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.studentDetailView,
      arguments: StudentDetailViewArguments(
        key: key,
        teacherId: teacherId,
        studentId: studentId,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStudentQuizRecordView({
    _i41.Key? key,
    required _i43.StudentTrackerSummary summary,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.studentQuizRecordView,
      arguments: StudentQuizRecordViewArguments(key: key, summary: summary),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithQuizAttemptDetailView({
    _i41.Key? key,
    required _i44.QuizAttemptRecord attempt,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.quizAttemptDetailView,
      arguments: QuizAttemptDetailViewArguments(key: key, attempt: attempt),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }
}

import 'package:englify_app/UI/views/feedback/feedback_view.dart';
import 'package:englify_app/UI/views/rules/rules_view.dart';
import 'package:englify_app/UI/views/student_flow/bottom_navigation/bottom_navi_view.dart';
import 'package:englify_app/UI/views/Role_selection/role_selection.dart';
import 'package:englify_app/UI/views/auth/auth_view.dart';

import 'package:englify_app/UI/views/classroomcode/classroom_view.dart';
import 'package:englify_app/UI/views/email_verification/email_verification_view.dart';
import 'package:englify_app/UI/views/forgatepassword/forpass_view.dart';
import 'package:englify_app/UI/views/login/login_view.dart';
import 'package:englify_app/UI/views/onbording/onbording_view.dart';
import 'package:englify_app/UI/views/personalization/personalization_view.dart';
import 'package:englify_app/UI/views/privecy&policy/privecyandpolicy_view.dart';
import 'package:englify_app/UI/views/signup/signup_email_view.dart';
import 'package:englify_app/UI/views/signup/signup_password_view.dart';
import 'package:englify_app/UI/views/splach/splach_view.dart';
import 'package:englify_app/UI/views/changepassword/changepassword_view.dart';
import 'package:englify_app/UI/views/student_flow/profile/std_profile_view.dart';
import 'package:englify_app/UI/views/student_flow/quiz_attempt/quiz_attempt_view.dart';
import 'package:englify_app/UI/views/student_flow/select_lesson/std_select_lesson_view.dart';
import 'package:englify_app/UI/views/student_flow/std_lesson_detail/std_lessondetail_view.dart';
import 'package:englify_app/UI/views/student_flow/studenhome/student_home_view.dart';
import 'package:englify_app/UI/views/student_flow/student_classroom_detail/student_classroom_detai_view.dart';
import 'package:englify_app/UI/views/student_flow/student_classroom_detail/student_classroom_detail_viewmodel.dart';
import 'package:englify_app/UI/views/student_flow/student_dashboard/student_dashboard_view.dart';
import 'package:englify_app/UI/views/student_flow/student_fav/student_fav_view.dart';
import 'package:englify_app/UI/views/teacher_flow/classroom_create/classroom_create_view.dart';
import 'package:englify_app/UI/views/teacher_flow/classroom_detail/classroomdetail_view.dart';
import 'package:englify_app/UI/views/teacher_flow/create_lessons/create_lesson_view.dart';
import 'package:englify_app/UI/views/teacher_flow/create_quiz/create_quiz_view.dart';
import 'package:englify_app/UI/views/teacher_flow/lesson_detail/lesson_detail_view.dart';
import 'package:englify_app/UI/views/teacher_flow/std_detail/std_details_view.dart';
import 'package:englify_app/UI/views/teacher_flow/std_list/std_list_view.dart';
import 'package:englify_app/UI/views/teacher_flow/teacher_bottom_tabs/teacher_bottom_tab_view.dart';
import 'package:englify_app/UI/views/teacher_flow/teacher_dashboard/teacher_dashboard_view.dart';
import 'package:englify_app/UI/views/teacher_flow/teacher_home/teacher_home_view.dart';
import 'package:englify_app/UI/views/teacher_flow/teacher_profile/teacher_profile_view.dart';
import 'package:englify_app/UI/views/teacher_flow/teacher_tracker/teacher_tracker_view.dart';
import 'package:englify_app/UI/views/teacher_flow/teacher_tracker/student_quiz_record_view.dart';
import 'package:englify_app/UI/views/teacher_flow/teacher_tracker/quiz_attempt_detail_view.dart';
import 'package:englify_app/UI/views/terms&condition/terms&cond_view.dart';
import 'package:englify_app/services/analytics_service.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/cloudniry_service.dart';
import 'package:englify_app/services/create_lesson_service.dart';
import 'package:englify_app/services/dashboard_service.dart';
import 'package:englify_app/services/favourite_service.dart';
import 'package:englify_app/services/file_viewer_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/classroom_service.dart';
import 'package:englify_app/services/notification_service.dart';
import 'package:englify_app/services/tracker_service.dart';
import 'package:englify_app/services/pints_service.dart';
import 'package:englify_app/services/profile_service.dart';
import 'package:englify_app/services/quiz_service.dart';
import 'package:englify_app/services/storage_service.dart';
import 'package:englify_app/services/user_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplachView, initial: true),
    MaterialRoute(page: OnbordingView),
    MaterialRoute(page: RoleSelection),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: Signupemailview),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: EmailVerificationView),
    MaterialRoute(page: SignupPasswordView),
    MaterialRoute(page: PersonalizationView),
    MaterialRoute(page: TeacherHomeView),
    MaterialRoute(page: ClassroomcodeView),
    MaterialRoute(page: ForgotPasswordView),
    MaterialRoute(page: StudentHomeView),
    MaterialRoute(page: StudentDashboardView),
    MaterialRoute(page: StudentFavView),
    MaterialRoute(page: BottomNaviView),
    MaterialRoute(page: PrivecyandpolicyView),
    MaterialRoute(page: TermsandcondView),
    MaterialRoute(page: ClassroomCreateView),
    MaterialRoute(page: TeacherDashboardView),
    MaterialRoute(page: TeacherTrackerView),
    MaterialRoute(page: TeacherProfileView),
    MaterialRoute(page: TeacherBottomTabView),
    MaterialRoute(page: ClassroomdetailView),
    MaterialRoute(page: CreateLessonView),
    MaterialRoute(page: LessonDetailView),
    MaterialRoute(page: CreateQuizView),
    MaterialRoute(page: StudentClassroomDetaiView),
    MaterialRoute(page: StdLessondetailView),
    MaterialRoute(page: StdSelectLessonView),
    MaterialRoute(page: QuizAttemptView),
    MaterialRoute(page: StdProfileView),
    MaterialRoute(page: ChangePasswordView),
    MaterialRoute(page: FeedbackView),
    MaterialRoute(page: RulesView),
    MaterialRoute(page: StudentsListView),
    MaterialRoute(page: StudentDetailView),
    MaterialRoute(page: StudentQuizRecordView),
    MaterialRoute(page: QuizAttemptDetailView),
    
  
    

  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: LocalStorageService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: classroomservice),
    LazySingleton(classType: StorageService),
    LazySingleton(classType: CloudinaryService),
    LazySingleton(classType: CreateLessonService),
    LazySingleton(classType: FileViewerService),
    LazySingleton(classType: QuizService),
    LazySingleton(classType: PointsService),
    LazySingleton(classType: FavouriteService),
    LazySingleton(classType: ProfileService),
    LazySingleton(classType: DashboardService),
    LazySingleton(classType: NotificationService),
    LazySingleton(classType: TrackerService),
    LazySingleton(classType: AnalyticsService),
  ],
)
class App {}

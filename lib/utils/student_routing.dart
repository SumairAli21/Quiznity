import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/classroom_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/user_service.dart';
import 'package:stacked_services/stacked_services.dart';

/// Where [routeSignedInStudent] sent the student.
///
/// Returned so a caller can do extra work for a specific destination — the
/// splash screen, for example, only consumes a pending notification deep link
/// once the student has actually landed on the home shell.
enum StudentDestination { personalization, classroomCode, home }

/// Sends a signed-in student to the screen they belong on.
///
/// Every entry point into the student flow — email login, Google/Apple
/// sign-in, the email-verification gate and cold start — has to answer the
/// same question, so the rule lives here once instead of being re-implemented
/// (and drifting) in four viewmodels.
///
/// The order matters:
///
/// 1. **Already enrolled in a class → home.** An enrolled student is fully
///    onboarded, so they are never re-prompted. Checking this first also
///    protects accounts created before the name was persisted to Firestore:
///    those have classes but no `users/{uid}.name`, and a name-first check
///    would drag them back through personalization.
/// 2. **Otherwise, no saved name → personalization.** This is the one-time
///    step.
/// 3. **Otherwise → join-by-code.** Name is set but no class yet.
///
/// Firestore is the source of truth for the name. Local storage is only a
/// mirror, and `LocalStorageService.syncsession` deliberately clears it
/// whenever the signed-in account changes — so reading the cache here is what
/// used to make a returning student enter their name on every fresh session.
/// When Firestore does hold a name, the mirror is re-seeded on the way past.
Future<StudentDestination> routeSignedInStudent(String uid) async {
  final navigation = locator<NavigationService>();
  final localstorage = locator<LocalStorageService>();
  final classroom = locator<classroomservice>();
  final users = locator<UserService>();

  bool hasclasses = false;
  try {
    hasclasses = await classroom.hasStudentJoinedAnyClass(uid);
  } catch (e) {
    // Offline or a failed read — fall through to the onboarding checks rather
    // than stranding the user on the screen they came from.
    print("Class check failed while routing student: $e");
  }

  if (hasclasses) {
    await localstorage.setclassroomjointrue();
    navigation.replaceWithBottomNaviView();
    return StudentDestination.home;
  }

  await localstorage.clearclassroomjoin();

  String? savedname;
  try {
    savedname = await users.getUserName(uid);
  } catch (e) {
    print("Name lookup failed while routing student: $e");
  }

  if (savedname == null) {
    navigation.replaceWithPersonalizationView();
    return StudentDestination.personalization;
  }

  await localstorage.saveusername(savedname);
  navigation.replaceWithClassroomcodeView();
  return StudentDestination.classroomCode;
}

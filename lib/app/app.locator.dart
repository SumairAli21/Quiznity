// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/analytics_service.dart';
import '../services/auth_service.dart';
import '../services/classroom_service.dart';
import '../services/cloudniry_service.dart';
import '../services/create_lesson_service.dart';
import '../services/dashboard_service.dart';
import '../services/favourite_service.dart';
import '../services/file_viewer_service.dart';
import '../services/local_storage_service.dart';
import '../services/notification_service.dart';
import '../services/pints_service.dart';
import '../services/profile_service.dart';
import '../services/quiz_service.dart';
import '../services/storage_service.dart';
import '../services/tracker_service.dart';
import '../services/user_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
  // Register environments
  locator.registerEnvironment(
    environment: environment,
    environmentFilter: environmentFilter,
  );

  // Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => LocalStorageService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => classroomservice());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => CloudinaryService());
  locator.registerLazySingleton(() => CreateLessonService());
  locator.registerLazySingleton(() => FileViewerService());
  locator.registerLazySingleton(() => QuizService());
  locator.registerLazySingleton(() => PointsService());
  locator.registerLazySingleton(() => FavouriteService());
  locator.registerLazySingleton(() => ProfileService());
  locator.registerLazySingleton(() => DashboardService());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => TrackerService());
  locator.registerLazySingleton(() => AnalyticsService());
}

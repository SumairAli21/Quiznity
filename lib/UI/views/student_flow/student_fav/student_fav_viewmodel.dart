import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/create_lesson_service.dart';
import 'package:englify_app/services/favourite_service.dart';
import 'package:englify_app/utils/app_feedback.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentFavViewmodel  extends BaseViewModel{
   final _navigationService = locator<NavigationService>();
  final _favService = locator<FavouriteService>();
  final _lessonService = locator<CreateLessonService>();

  /// Guards against a second tap while the real lesson is being fetched.
  bool _isopeninglesson = false;

  List<Map<String, dynamic>> allFavourites = [];
  List<Map<String, dynamic>> filteredFavourites = [];

  final searchController = TextEditingController();

  Future<void> init() async {
    setBusy(true);
    try {
      allFavourites = await _favService.getfav();
      filteredFavourites = List.from(allFavourites);
    } catch (e) {
      print('Failed to load favourites: $e');
    }
    setBusy(false);
  }

  void onSearchChange(String value) {
    if (value.trim().isEmpty) {
      filteredFavourites = List.from(allFavourites);
    } else {
      filteredFavourites = allFavourites
          .where((fav) => (fav['lessonTitle'] as String)
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  /// Opens a favourited lesson through the SAME screens as the normal
  /// Lessons flow, with the same data.
  ///
  /// A favourite document is only a denormalised snapshot — `lessonId`,
  /// `lessonTitle`, `classId`, `className`, `imageUrl`. It carries no
  /// `lessonNumber`, no `description` and no `contentUrl`. Building a
  /// [LessonData] directly from it (which is what this did before) therefore
  /// produced "Lesson 00", an empty description, and a null `contentUrl` —
  /// which is why the attached PDF/document silently vanished, since
  /// StdLessondetailViewmodel derives `isPdf` / `isFileSupported` from it.
  ///
  /// `lessonId` is the durable reference, so it is used to re-read the real
  /// `lessons/{lessonId}` document and hand StdSelectLessonView exactly the
  /// [LessonData] that StudentClassroomDetailViewmodel would have passed.
  Future<void> onFavTap(BuildContext context, Map<String, dynamic> fav) async {
    if (_isopeninglesson) return;

    final lessonid = (fav['lessonId'] as String?)?.trim() ?? '';
    if (lessonid.isEmpty) {
      if (context.mounted) {
        showAppSnackBar(context, 'This favourite is no longer available.',
            isError: true);
      }
      return;
    }

    _isopeninglesson = true;
    final lesson = await _lessonService.getLessonById(lessonid);
    _isopeninglesson = false;

    if (lesson == null) {
      if (context.mounted) {
        showAppSnackBar(
            context, 'This lesson is no longer available. It may have been removed.',
            isError: true);
      }
      return;
    }

    // classId comes off the lesson itself (authoritative). The class name is
    // only a label, so the denormalised copy on the favourite is fine — and it
    // is what the classroom flow puts in this map too.
    final classroom = {
      'id': lesson.classId.isNotEmpty ? lesson.classId : (fav['classId'] ?? ''),
      'name': fav['className'] ?? '',
    };

    await _navigationService.navigateToStdSelectLessonView(
      lesson: lesson,
      classroom: classroom,
    );

    // The lesson may have been un-favourited from the detail screen, so
    // refresh rather than leaving a stale row behind.
    await init();
  }

  void onBack() => _navigationService.back();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
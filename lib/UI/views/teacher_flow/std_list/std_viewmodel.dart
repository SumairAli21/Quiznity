import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/dashboard_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentsListViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dashboardService = locator<DashboardService>();
 
  final String teacherId;
  StudentsListViewmodel({required this.teacherId});

  /// Full list from Firestore. [students] is the filtered view of it that the
  /// UI renders, so filtering never loses the un-matched entries.
  List<StudentSummary> _allstudents = [];
  List<StudentSummary> students = [];

  final searchcontroller = TextEditingController();
  bool issearching = false;

  Future<void> init() async {
    setBusy(true);
    try {
      _allstudents = await _dashboardService.getAllStudents(teacherId);
      _applyfilter();
    } catch (e) {
      print('Students list error: $e');
    }
    setBusy(false);
  }

  /// Opens/closes the name search field. Closing clears the query so the full
  /// list comes back.
  void togglesearch() {
    issearching = !issearching;
    if (!issearching) {
      searchcontroller.clear();
      _applyfilter();
    }
    notifyListeners();
  }

  void onsearchchanged(String _) {
    _applyfilter();
    notifyListeners();
  }

  void _applyfilter() {
    final query = searchcontroller.text.trim().toLowerCase();
    students = query.isEmpty
        ? List.of(_allstudents)
        : _allstudents
            .where((s) => s.name.toLowerCase().contains(query))
            .toList();
  }

  /// True when a query is active but matched nobody — lets the view show
  /// "No students match" instead of the "No students yet" empty state.
  bool get hasnomatches =>
      students.isEmpty && searchcontroller.text.trim().isNotEmpty;

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }

  void onStudentTap(String studentId) {
    _navigationService.navigateTo(
      Routes.studentDetailView,
      arguments: StudentDetailViewArguments(
        teacherId: teacherId,
        studentId: studentId,
      ),
    );
  }
 
  void onBack() => _navigationService.back();
}
 
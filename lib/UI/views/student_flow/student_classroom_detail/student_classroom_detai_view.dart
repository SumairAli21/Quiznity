import 'package:englify_app/UI/views/student_flow/student_classroom_detail/student_classroom_detail_viewmodel.dart';
import 'package:englify_app/UI/widgets/custom_lesson_card.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StudentClassroomDetaiView extends StatelessWidget {
  final Map<String, dynamic> classroom;
  const StudentClassroomDetaiView({super.key, required this.classroom});

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;
    final isTablet = context.isTablet;

    final gridCrossCount = isTablet
        ? (isLandscape ? 4 : 3)
        : (isLandscape ? 3 : 2);
    final gridAspectRatio = isTablet
        ? (isLandscape ? 1.2 : 0.85)
        : (isLandscape ? 1.1 : 0.78);
    final hPadding = isTablet ? 24.0 : 16.0;

    return ViewModelBuilder<StudentClassroomDetailViewmodel>.reactive(
      viewModelBuilder: () =>
          StudentClassroomDetailViewmodel(classroom),
      onViewModelReady: (model) => model.loadlesson(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/dies_logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                    color: Colors.grey.withOpacity(0.1)),
              ),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: hPadding,
                        vertical: isLandscape ? 6 : 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: isLandscape ? 4 : 15),

                          // Header
                          Row(
                            children: [
                              GestureDetector(
                                onTap: model.onback,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.arrow_back,
                                      color: Colors.black),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    model.className,
                                    style: TextStyle(
                                      fontSize: isTablet ? 20 : 18,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                            ],
                          ),

                          const SizedBox(height: 5),
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: const Color.fromARGB(38, 255, 255, 255),
                          ),
                          SizedBox(height: isLandscape ? 8 : 16),

                          // Search
                          SizedBox(
                            height: isLandscape
                                ? (isTablet ? 50 : 42)
                                : (isTablet ? 56 : 48),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: model.serachcontroller,
                                cursorColor: Colors.black,
                                onChanged: model.onsearchchanged,
                                decoration: InputDecoration(
                                  hintText: "Search Lesson",
                                  prefixIcon: Icon(Icons.search,
                                      color: Colors.grey[400]),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(28),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF2F6BFF), width: 1.6),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: isLandscape ? 8 : 16),
                        ],
                      ),
                    ),

                    // Grid
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: hPadding),
                        child: model.isBusy
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white))
                            : model.lessons.isEmpty
                                ? Center(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            model.serachcontroller.text
                                                    .isNotEmpty
                                                ? Icons.search_off
                                                : Icons.menu_book_outlined,
                                            size: isTablet ? 80 : 64,
                                            color: Colors.white70,
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            model.serachcontroller.text
                                                    .isNotEmpty
                                                ? "No Lesson Found"
                                                : "No Lessons Available Yet",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize:
                                                  isTablet ? 18 : 16,
                                            ),
                                          ),
                                          if (model.serachcontroller.text
                                              .isNotEmpty)
                                            TextButton(
                                              onPressed:
                                                  model.clearseach,
                                              child: const Text(
                                                "Clear Search",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  )
                                : GridView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(
                                        bottom:
                                            isLandscape ? 16 : 24),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: gridCrossCount,
                                      crossAxisSpacing:
                                          isTablet ? 16 : 12,
                                      mainAxisSpacing: isTablet ? 16 : 12,
                                      childAspectRatio: gridAspectRatio,
                                    ),
                                    itemCount: model.lessons.length,
                                    itemBuilder: (context, index) {
                                      final lesson =
                                          model.lessons[index];
                                      return LessonCard(
                                        lessonName: lesson.title,
                                        lessonId: lesson.id,
                                        onTap: () => model
                                            .gotolessondetail(lesson),
                                        imageUrl: lesson.imageUrl,
                                      );
                                    },
                                  ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
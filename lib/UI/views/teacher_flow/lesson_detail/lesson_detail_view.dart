import 'package:englify_app/UI/views/teacher_flow/lesson_detail/lesson_detail_viewmodel.dart';
import 'package:englify_app/UI/widgets/pdf_page_viewer.dart';
import 'package:englify_app/models/lesson_data_model.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LessonDetailView extends StatelessWidget {
  final LessonData lessons;
  final Map<String, dynamic> classroom;
  const LessonDetailView(
      {super.key, required this.classroom, required this.lessons});

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;

    return ViewModelBuilder<LessonDetailViewmodel>.reactive(
      viewModelBuilder: () =>
          LessonDetailViewmodel(lesson: lessons, classroom: classroom),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
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
                  color: Colors.black.withOpacity(0.25),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    // ── Fixed header (scroll nahi hoga)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: isLandscape ? 6 : 12,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: isLandscape ? 4 : 15),

                          // Back + title row
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
                                    '${model.className} - ${model.classCode}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: context.rf(18)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                            ],
                          ),

                          const SizedBox(height: 10),
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: const Color.fromARGB(90, 255, 255, 255),
                          ),
                          const SizedBox(height: 10),

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              model.lessonNumberText,
                              style: TextStyle(
                                fontSize: context.rf(14),
                                color: Colors.white54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Introduction to ${lessons.title}',
                              style: TextStyle(
                                fontSize: context.rf(isLandscape ? 16 : 22),
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          if (lessons.description.isNotEmpty &&
                              !isLandscape) ...[
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                lessons.description,
                                style: TextStyle(
                                  fontSize: context.rf(14),
                                  color: Colors.white.withOpacity(0.7),
                                  height: 1.5,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],

                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: context.rs(12),
                                      vertical: context.rs(6)),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.menu_book,
                                          color: Colors.white,
                                          size: context.rs(16)),
                                      SizedBox(width: context.rs(6)),
                                      Text("Grammar Basics",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: context.rf(12))),
                                    ],
                                  ),
                                ),
                                SizedBox(width: context.rs(10)),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: context.rs(12),
                                      vertical: context.rs(6)),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit_note,
                                          color: Colors.black,
                                          size: context.rs(16)),
                                      SizedBox(width: context.rs(6)),
                                      Text("Mini Exercises",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: context.rf(12))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: const Color.fromARGB(98, 255, 255, 255),
                          ),
                        ],
                      ),
                    ),

                    // ── Scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: _buildContent(context, model, lessons),
                        ),
                      ),
                    ),

                    // ── Create Quiz button
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: isLandscape ? 8 : 12,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: context.rs(52),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2F6BFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: model.oncratequiz,
                          child: Text(
                            "Create Quiz",
                            style: TextStyle(
                              fontSize: context.rf(16),
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
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

  Widget _buildContent(
      BuildContext context, LessonDetailViewmodel model, LessonData lessons) {
    final url = (lessons.contentUrl ?? "").trim().toLowerCase();

    if (url.contains(".jpg") ||
        url.contains(".png") ||
        url.contains(".jpeg")) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          lessons.contentUrl!.trim(),
          fit: BoxFit.contain,
        ),
      );
    }

    if (model.isFileSupported) {
      return Align(
        alignment: Alignment.topCenter,
        child: FileAttachmentCard(
          fileUrl: lessons.contentUrl!.trim(),
          fileName: model.fileName,
          isDownloading: model.isDownloading,
          progress: model.downloadProgress,
          onTap: model.openFile,
        ),
      );
    }

    return Text(
      lessons.contentUrl ?? '',
      style: TextStyle(
        fontSize: context.rf(15),
        height: 1.6,
        color: Colors.white,
      ),
    );
  }
}
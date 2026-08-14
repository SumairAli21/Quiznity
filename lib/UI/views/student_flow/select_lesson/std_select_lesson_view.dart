import 'package:englify_app/UI/widgets/app_logo.dart';
import 'package:englify_app/UI/views/student_flow/select_lesson/std_select_lesson_viewmodel.dart';
import 'package:englify_app/UI/widgets/animated_lessoncard.dart';
import 'package:englify_app/models/lesson_data_model.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StdSelectLessonView extends StatelessWidget {
  final LessonData lesson;
  final Map<String, dynamic> classroom;
  StdSelectLessonView({
    super.key,
    required this.lesson,
    required this.classroom,
  });

  @override
  Widget build(BuildContext context) {
    final islandscape = context.isLandscape;
    return ViewModelBuilder<StdSelectLessonViewmodel>.reactive(
      viewModelBuilder: () =>
          StdSelectLessonViewmodel(lesson: lesson, classrom: classroom),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/dies_logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black.withOpacity(0.35),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.rs(12),
                    vertical: islandscape ? context.rs(6) : context.rs(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.rs(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(child: AppLogo.header()),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.rs(12),
                              vertical: context.rs(6),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: context.rs(10),
                                  width: context.rs(20),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/coins.png',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: context.rs(3)),
                                Text(
                                  model.scoretext,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: context.rf(14),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: islandscape
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: AnimatedLessonCard(
                                        imageUrl: model.imageurl,
                                        lessonTitle: model.lessonname,
                                        isLandscape: islandscape,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: context.rs(24),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _builstartquizbutton(context, model),
                                          SizedBox(height: context.rs(15)),
                                          _readtheorybutton(context, model),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : LayoutBuilder(
                                builder: (context, c) =>
                                    SingleChildScrollView(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        minHeight: c.maxHeight),
                                    child: IntrinsicHeight(
                                      child: Column(
                                        children: [
                                          Spacer(),
                                          Center(
                                            child: AnimatedLessonCard(
                                              imageUrl: model.imageurl,
                                              lessonTitle: model.lessonname,
                                              isLandscape: islandscape,
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                context.rs(24),
                                                0,
                                                context.rs(24),
                                                context.rs(40)),
                                            child: Column(
                                              children: [
                                                _builstartquizbutton(
                                                    context, model),
                                                SizedBox(
                                                    height: context.rs(15)),
                                                _readtheorybutton(
                                                    context, model),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _builstartquizbutton(
      BuildContext context, StdSelectLessonViewmodel model) {
    return SizedBox(
      width: double.infinity,
      height: context.rs(52),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: model.isQuizAttempted
              ? Colors
                    .grey // ← attempted = grey
              : const Color(0xFF2F6BFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: model.isQuizAttempted
            ? null // ← disable
            : model.gotoattemptQuiz,
        child: Text(
          model.isQuizAttempted
              ? 'Already Attempted ✓' // ← text change
              : 'START QUIZ',
          style: TextStyle(
            color: Colors.white,
            fontSize: context.rf(18),
            fontFamily: 'button',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _readtheorybutton(
      BuildContext context, StdSelectLessonViewmodel model) {
    return SizedBox(
      width: double.infinity,
      height: context.rs(52),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.white, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: model.gotolessondetail,
        child: Text(
          'READ THEORY',
          style: TextStyle(
            fontSize: context.rf(18),
            fontFamily: 'button',
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

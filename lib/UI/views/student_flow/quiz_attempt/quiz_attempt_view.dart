import 'package:englify_app/UI/views/student_flow/quiz_attempt/quiz_attempt_viewmodel.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class QuizAttemptView extends StatelessWidget {
  final String classId;
  final String lessonId;
  final String lessonTitle;

  const QuizAttemptView({
    super.key,
    required this.classId,
    required this.lessonId,
    required this.lessonTitle,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;

    return ViewModelBuilder<QuizAttemptViewmodel>.reactive(
      viewModelBuilder: () => QuizAttemptViewmodel(
        classId: classId,
        lessonId: lessonId,
        lessonTitle: lessonTitle,
      ),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              // ── Background
              Positioned.fill(
                child: Image.asset(
                  'assets/images/dies_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),

              SafeArea(
                child: model.isBusy
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : model.questions.isEmpty
                        ? Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.quiz_outlined,
                                      color: Colors.white70,
                                      size: context.rs(64)),
                                  SizedBox(height: context.rs(16)),
                                  Text(
                                    'No quiz available for this lesson',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: context.rf(16)),
                                  ),
                                  SizedBox(height: context.rs(20)),
                                  TextButton(
                                    onPressed: model.onBack,
                                    child: const Text('Go Back',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ── Top bar
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.rs(16),
                                  vertical: isLandscape
                                      ? context.rs(6)
                                      : context.rs(12),
                                ),
                                child: Row(
                                  children: [
                                    // Points badge
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: context.rs(10),
                                          vertical: context.rs(5)),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/coins.png',
                                            height: context.rs(18),
                                            width: context.rs(18),
                                          ),
                                          SizedBox(width: context.rs(4)),
                                          Text(
                                            '${model.earnedPoints}/${model.totalPoints}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: context.rf(13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),

                                    // Info button — quiz rules
                                    GestureDetector(
                                      onTap: () =>
                                          _showRulesDialog(context, model),
                                      child: Container(
                                        padding: EdgeInsets.all(context.rs(8)),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.info_outline,
                                          color: const Color(0xFF2F6BFF),
                                          size: context.rs(22),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (model.currentQuestion?.timerEnabled == true)
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: context.rs(16),
    vertical: context.rs(8),
  ),

  child: Stack(
    children: [

      ClipRRect(
        borderRadius:
            BorderRadius.circular(30),

        child: LinearProgressIndicator(
          value: model.progress,
          minHeight: context.rs(24),

          backgroundColor:
              Colors.white.withOpacity(.25),

          valueColor:
              AlwaysStoppedAnimation(
                model.progress > .50
                  ? const Color(0xFF2F6BFF)
                  : model.progress > .20
                    ? Colors.orange
                    : Colors.red,
              ),
        ),
      ),

      Positioned.fill(
        child: Center(
          child: Text(
            "${model.timeLeft}s",

            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

    ],
  ),
),
                              // ── Feedback bar
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: model.feedbackMessage.isEmpty
                                    ? 0
                                    : context.rs(40),
                                width: double.infinity,
                                color: model.isAnswerRevealed
                                    ? (model.isCorrectAnswer
                                        ? Colors.green.withOpacity(0.9)
                                        : Colors.red.withOpacity(0.9))
                                    : Colors.transparent,
                                child: model.feedbackMessage.isEmpty
                                    ? null
                                    : Center(
                                        child: Text(
                                          model.feedbackMessage,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: context.rf(14),
                                          ),
                                        ),
                                      ),
                              ),

                              // ── Question content
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isLandscape
                                        ? context.rs(40)
                                        : context.rs(20),
                                    vertical: context.rs(16),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Question type label
                                      Text(
                                        'CHOOSE THE CORRECT ANSWER',
                                        style: TextStyle(
                                          fontSize: context.rf(18),
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          fontFamily: 'heading',
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      SizedBox(height: context.rs(8)),

                                      // Question text
                                      Text(
                                        model.currentQuestion?.questionText ??
                                            '',
                                        style: TextStyle(
                                          fontSize: isLandscape
                                              ? context.rf(16)
                                              : context.rf(18),
                                          color:
                                              Colors.white.withOpacity(0.85),
                                          height: 1.4,
                                        ),
                                      ),
                                      SizedBox(height: context.rs(20)),

                                      // ── Options
                                      ...List.generate(
                                        model.currentQuestion?.options.length ??
                                            0,
                                        (oIndex) {
                                          final option = model.currentQuestion!
                                              .options[oIndex];
                                          final isSelected =
                                              model.selectedOptionIndex ==
                                                  oIndex;
                                          final isRevealed =
                                              model.isAnswerRevealed;

                                          Color bgColor = Colors.white
                                              .withOpacity(0.92);
                                          Color textColor = Colors.black87;
                                          Color borderColor =
                                              Colors.transparent;

                                          if (isRevealed) {
                                            if (option.isCorrect) {
                                              // correct answer green
                                              bgColor = Colors.green.shade400;
                                              textColor = Colors.white;
                                              borderColor =
                                                  Colors.green.shade700;
                                            } else if (isSelected &&
                                                !option.isCorrect) {
                                              // wrong selected red
                                              bgColor = Colors.red.shade300;
                                              textColor = Colors.white;
                                              borderColor =
                                                  Colors.red.shade700;
                                            }
                                          } else if (isSelected) {
                                            // selected but not revealed
                                            borderColor =
                                                const Color(0xFF2F6BFF);
                                            bgColor = Colors.white;
                                          }

                                          return GestureDetector(
                                            onTap: () =>
                                                model.selectOption(oIndex),
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              margin: EdgeInsets.only(
                                                  bottom: context.rs(12)),
                                              padding:
                                                  EdgeInsets.symmetric(
                                                horizontal: context.rs(16),
                                                vertical: context.rs(14),
                                              ),
                                              decoration: BoxDecoration(
                                                color: bgColor,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                  color: borderColor,
                                                  width: 2,
                                                ),
                                              ),
                                              child: Text(
                                                option.text,
                                                style: TextStyle(
                                                  fontSize: context.rf(15),
                                                  color: textColor,
                                                  fontWeight: isSelected
                                                      ? FontWeight.w600
                                                      : FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // ── Continue button
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                  context.rs(20),
                                  0,
                                  context.rs(20),
                                  isLandscape ? context.rs(12) : context.rs(24),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: isLandscape ? context.rs(42) : context.rs(52),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          model.selectedOptionIndex == null
                                              ? Colors.grey
                                              : const Color(0xFF2F6BFF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14),
                                      ),
                                      elevation: 0,
                                    ),
                                    onPressed: model.selectedOptionIndex == null
                                        ? null
                                        : () => model.onContinue(context),
                                    // ── Continue button
child: Text(
  // Last question hai aur answer reveal ho chuka → SUBMIT
  model.isLastQuestion && model.isAnswerRevealed
      ? 'SUBMIT'
      : 'CONTINUE',
  style: TextStyle(
    fontSize: context.rf(16),
    fontWeight: FontWeight.w800,
    color: Colors.white,
    letterSpacing: 1.5,
    fontFamily: 'button',
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

  /// Explains how scoring and the timer work. Nothing else in the flow tells
  /// the student that a timeout scores zero, so this is the only place it is
  /// stated.
  void _showRulesDialog(BuildContext context, QuizAttemptViewmodel model) {
    final perQuestion = model.pointsPerQuestion;
    final hasTimer =
        model.questions.any((q) => q.timerEnabled);

    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            const Icon(Icons.info_outline, color: Color(0xFF2F6BFF)),
            const SizedBox(width: 8),
            const Text(
              'How this quiz works',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _RuleLine(
              icon: Icons.emoji_events_outlined,
              text: 'This quiz is worth ${model.totalPoints} points across '
                  '${model.questions.length} questions — '
                  '$perQuestion points each.',
            ),
            const _RuleLine(
              icon: Icons.check_circle_outline,
              text: 'A correct answer earns the full points for that '
                  'question. A wrong answer earns 0.',
            ),
            if (hasTimer)
              const _RuleLine(
                icon: Icons.timer_outlined,
                text: 'Timed questions score 0 if the timer runs out, so '
                    'answer before it empties.',
              ),
            const _RuleLine(
              icon: Icons.touch_app_outlined,
              text: 'Pick an option and press Continue to check it, then '
                  'press again to move on.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Got it',
              style: TextStyle(
                color: Color(0xFF2F6BFF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleLine extends StatelessWidget {
  final IconData icon;
  final String text;

  const _RuleLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF2F6BFF)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.4,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
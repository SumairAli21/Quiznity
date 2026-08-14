import 'package:englify_app/UI/views/rules/rules_viewmodel.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RulesView extends StatelessWidget {
  const RulesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RulesViewmodel>.nonReactive(
      viewModelBuilder: () => RulesViewmodel() , 
      builder: (context,model,child){
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/dies_logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.25),
                      Colors.black.withOpacity(0.25),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.rs(12), vertical: context.rs(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.rs(15)),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: model.onback,
                            child: Container(
                              padding: EdgeInsets.all(context.rs(8)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.arrow_back, color: Colors.black),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Rules & Guidelines",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: context.rf(18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.rs(5)),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: Colors.white54,
                      ),
                      SizedBox(height: context.rs(15)),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ResponsiveContainer(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Quiz Rules & Guidelines",
                                style: TextStyle(
                                  fontFamily: "heading",
                                  fontSize: context.rf(30),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: context.rs(4)),
                              Text(
                                "Last Updated: February 2026",
                                style: TextStyle(
                                  fontSize: context.rf(12),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(height: context.rs(8)),
                              Text(
                                "Welcome to the quiz platform. Please read the following rules carefully before using the app.",
                                style: TextStyle(
                                  fontSize: context.rf(14),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: context.rs(12)),

                              // Student Rules Section
                              _buildSectionHeader(context, "🎮 Student Rules"),
                              _buildSection(
                                context,
                                "Quiz Participation",
                                "Students should read each question carefully before submitting an answer. Some quizzes may include timers, limited attempts, or shuffled questions.",
                              ),
                              _buildSection(
                                context,
                                "Fair Usage",
                                "Students are expected to complete quizzes honestly without using unfair methods or sharing answers during assessments.",
                              ),
                              _buildSection(
                                context,
                                "Progress & Scores",
                                "Quiz scores and lesson progress are automatically recorded and may be visible to teachers for performance tracking.",
                              ),
                              _buildSection(
                                context,
                                "Technical Responsibility",
                                "Students should ensure a stable internet connection while attempting quizzes to avoid interruptions.",
                              ),

                              // Teacher Rules Section
                              _buildSectionHeader(context, "👨‍🏫 Teacher Rules"),
                              _buildSection(
                                context,
                                "Quiz Creation",
                                "Teachers should create clear, accurate, and educational quiz content suitable for students.",
                              ),
                              _buildSection(
                                context,
                                "Classroom Assignment",
                                "All quizzes must be assigned to the appropriate classroom before publishing.",
                              ),
                              _buildSection(
                                context,
                                "Publishing & Editing",
                                "Teachers are responsible for reviewing questions, answers, and quiz settings before making quizzes available to students.",
                              ),
                              _buildSection(
                                context,
                                "Student Monitoring",
                                "Teachers may review quiz attempts, scores, completion rates, and overall student performance analytics.",
                              ),

                              // General Guidelines Section
                              _buildSectionHeader(context, "📌 General Guidelines"),
                              Padding(
                                padding: EdgeInsets.only(bottom: context.rs(20)),
                                child: Text(
                                  "Users are expected to use the platform respectfully and for educational purposes only. Any misuse of the platform may result in restricted access or account limitations.\n\nFor additional support, please contact the app administrator or support team.",
                                  style: TextStyle(
                                    fontSize: context.rf(14),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
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
      }
      );
  }

}

Widget _buildSectionHeader(BuildContext context, String title) {
  return Padding(
    padding: EdgeInsets.only(bottom: context.rs(10), top: context.rs(4)),
    child: Text(
      title,
      style: TextStyle(
        fontFamily: "heading",
        fontSize: context.rf(18),
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildSection(BuildContext context, String title, String content) {
  return Padding(
    padding: EdgeInsets.only(bottom: context.rs(20)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: context.rf(14),
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: context.rs(8)),
        Text(
          content,
          style: TextStyle(
            fontSize: context.rf(14),
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
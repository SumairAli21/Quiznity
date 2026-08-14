import 'package:englify_app/UI/views/classroomcode/classroom_view_model.dart';
import 'package:englify_app/UI/widgets/app_logo.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ClassroomcodeView extends StatelessWidget {
  ClassroomcodeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;

    return ViewModelBuilder<ClassroomViewModel>.reactive(
      viewModelBuilder: () => ClassroomViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.rs(24),
                  vertical: context.rs(isLandscape ? 12 : 16),
                ),
                child: ResponsiveContainer(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: AppLogo.header(variant: AppLogoVariant.blue),
                        ),
                        SizedBox(width: context.rs(16)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE9EDEE),
                            padding: EdgeInsets.symmetric(
                              horizontal: context.rs(20),
                              vertical: context.rs(12),
                            ),
                          ),
                          onPressed: model.onback,
                          child: Text(
                            "Back",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.rs(isLandscape ? 16 : 24)),
                    Text(
                      "The best way to learn english",
                      style: TextStyle(
                        fontFamily: "heading",
                        fontSize: context.rf(isLandscape ? 24 : 30),
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: context.rs(8)),
                    Text(
                      "Join classroom to continue your learning journey",
                      style: TextStyle(
                        fontSize: context.rf(14),
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: context.rs(isLandscape ? 12 : 15)),
                    Text(
                      "Class code",
                      style: TextStyle(
                        fontSize: context.rf(15),
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: context.rs(4)),
                    TextField(
                      cursorColor: Colors.black,
                      controller: model.classcodecontroller,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Enter your class code",
                        hintStyle: TextStyle(color: Colors.black38),
                        errorText: model.errormessage,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey, width: 1.2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF2F6BFF), width: 1.6),
                        ),
                      ),
                    ),
                    SizedBox(height: context.rs(isLandscape ? 16 : 20)),
                    AppButton(
                      title: 'Join',
                      onTap: model.joinclass,
                      isLoading: model.isBusy,
                    ),
                    SizedBox(height: context.rs(20)), // Bottom padding
                  ],
                ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
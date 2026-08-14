import 'package:englify_app/UI/widgets/app_logo.dart';
import 'package:englify_app/UI/views/teacher_flow/classroom_create/classroom_create_viewmodel.dart';
import 'package:englify_app/UI/widgets/classroomcreate_dialog.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ClassroomCreateView extends StatelessWidget {
  const ClassroomCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClassroomCreateViewmodel>.reactive(
      viewModelBuilder: () => ClassroomCreateViewmodel(),
      builder: (context, model, child) {
       
       if (!model.isBusy && model.generatedClassCode != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => ClassroomSuccessDialog(
                classCode: model.generatedClassCode!,
                onDismiss: () {
                  Navigator.pop(context);
                  model.resetClassCode();
                  Navigator.pop(context);
                },
              ),
            );
          });
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.hPad),
                child: ResponsiveContainer(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Flexible so the wordmark yields to the Back button
                        // instead of overflowing the row on narrow screens.
                        const Flexible(
                          child: AppLogo.header(variant: AppLogoVariant.blue),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE9EDEE),
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
                    SizedBox(height: context.rs(20)),
                    Text(
                      "Create a new classroom",
                      style: TextStyle(
                        fontFamily: "heading",
                        fontSize: context.rf(30),
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: context.rs(8)),
                    Text(
                      "Set up a space for your students to learn and grow together.",
                      style: TextStyle(
                        fontSize: context.rf(14),
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: context.rs(20)),


                    Row(
                      children: [
                        Text(
                          "Classroom Image",
                          style: TextStyle(
                            fontSize: context.rf(16),
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                            fontSize: context.rf(16),
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.rs(8)),
                    GestureDetector(
                      onTap: model.pickImage,
                      child: Container(
                        height: context.rs(200),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: model.selectedImage != null 
                              ? Colors.transparent 
                              : Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: model.imageerror != null 
                                ? Colors.red 
                                : Colors.grey.shade300,
                            width: model.imageerror != null ? 1.5 : 1.2,
                          ),
                        ),
                        child: model.selectedImage != null
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      model.selectedImage!,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: model.removeImage,
                                      child: Container(
                                        padding: EdgeInsets.all(context.rs(6)),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: context.rs(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    size: context.rs(60),
                                    color: model.imageerror != null
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  SizedBox(height: context.rs(8)),
                                  Text(
                                    "Tap to add classroom image",
                                    style: TextStyle(
                                      fontSize: context.rf(14),
                                      color: Colors.black54,
                                    ),
                                  ),
                                  if (model.imageerror != null)
                                    Padding(
                                      padding: EdgeInsets.only(top: context.rs(8)),
                                      child: Text(
                                        model.imageerror!,
                                        style: TextStyle(
                                          fontSize: context.rf(12),
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                      ),
                    ),
                    SizedBox(height: context.rs(15)),

                    // Classroom Name
                    Row(
                      children: [
                        Text(
                          "Classroom Name",
                          style: TextStyle(
                            fontSize: context.rf(16),
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                            fontSize: context.rf(16),
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.rs(8)),
                    TextField(
                      cursorColor: Colors.black,
                      controller: model.classroomnamecontroller,
                      onChanged: model.onclassroomnamechanged,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        errorText: model.classroomnameerror,
                        hintText: "Enter your classroom name like English Grammar",
                        hintStyle: TextStyle(color: Colors.black38),
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
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.redAccent, width: 1.2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.redAccent, width: 1.6),
                        ),
                      ),
                    ),
                    SizedBox(height: context.rs(15)),


                    // Student Count
                    Row(
                      children: [
                        Text(
                          "How many students do you want to join",
                          style: TextStyle(
                            fontSize: context.rf(16),
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                            fontSize: context.rf(16),
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.rs(8)),
                    TextField(
                      cursorColor: Colors.black,
                      controller: model.studentcountcontroller,
                      onChanged: model.onstudentcountchanged,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorText: model.studentcounterror,
                        hintText: "e.g., 30",
                        hintStyle: TextStyle(color: Colors.black38),
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
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.redAccent, width: 1.2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.redAccent, width: 1.6),
                        ),
                      ),
                    ),
                    SizedBox(height: context.rs(100)),
                    AppButton(
                      title: "Create classroom",
                      onTap: model.oncreateclassroom,
                      isLoading: model.isBusy,
                    ),
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
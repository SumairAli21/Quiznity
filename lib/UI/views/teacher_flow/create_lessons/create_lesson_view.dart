import 'package:englify_app/UI/widgets/app_logo.dart';
import 'package:englify_app/UI/views/teacher_flow/create_lessons/create_leasson_viewmodel.dart';
import 'package:englify_app/UI/widgets/custom_lesson_sucess_dialog.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CreateLessonView extends StatelessWidget {
  String classid;
  CreateLessonView({super.key, required this.classid});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateLeassonViewmodel>.reactive(
      viewModelBuilder: () => CreateLeassonViewmodel(classid: classid),
      onViewModelReady: (model)=> model.init(),
      builder: (context, model, child) {
        if (!model.isBusy && model.generatedlessonid != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => LessonSuccessDialog(
                onDismiss: () {
                  Navigator.pop(context);
                  model.resetForm();
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
                    // ✅ Header
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
                            backgroundColor: const Color(0xFFE9EDEE),
                          ),
                          onPressed: model.onback,
                          child: const Text(
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
                      "Create Lesson",
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
                          fontSize: context.rf(14), color: Colors.black54),
                    ),
                    SizedBox(height: context.rs(20)),

                    // ✅ LESSON CARD IMAGE PICKER - same as classroom image picker
                    Row(
                      children: [
                        Text(
                          "Lesson Image",
                          style: TextStyle(
                            fontSize: context.rf(16),
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              fontSize: context.rf(16), color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: context.rs(8)),
                    GestureDetector(
                      onTap: model.pickimage,
                      child: Container(
                        height: context.rs(200),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: model.selectedImage != null
                              ? Colors.transparent
                              : const Color(0xFFF5F5F5),
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
                                      onTap: model.removeimage,
                                      child: Container(
                                        padding: EdgeInsets.all(context.rs(6)),
                                        decoration: const BoxDecoration(
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
                                    "Tap to add lesson image",
                                    style: TextStyle(
                                      fontSize: context.rf(14),
                                      color: model.imageerror != null
                                          ? Colors.red
                                          : Colors.black54,
                                    ),
                                  ),
                                  if (model.imageerror != null)
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: context.rs(8)),
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

                    // ✅ Lesson Name
                    Row(
                      children: [
                        Text(
                          "Lesson Name",
                          style: TextStyle(
                            fontSize: context.rf(16),
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              fontSize: context.rf(16), color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: context.rs(8)),
                    TextField(
                      cursorColor: Colors.black,
                      controller: model.lessonnamecontroller,
                      onChanged: model.onlesseonnamechnaged,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        errorText: model.lesssonnameerror,
                        hintText: "e.g. Room & Pronoun Basics",
                        hintStyle: const TextStyle(color: Colors.black38),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2F6BFF),
                            width: 1.6,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 1.2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 1.6,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.rs(15)),

                    // ✅ Class Description (optional)
                    Text(
                      "Lesson Description",
                      style: TextStyle(
                        fontSize: context.rf(16),
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: context.rs(8)),
                    TextField(
                      cursorColor: Colors.black,
                      controller: model.descriptioncontroller,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText:
                            "Briefly describe what students will learn in this lesson.",
                        hintStyle: const TextStyle(color: Colors.black38),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2F6BFF),
                            width: 1.6,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.rs(15)),

                    // ✅ Lesson Content file upload
                    Row(
                      children: [
                        Text(
                          "Lesson Content",
                          style: TextStyle(
                            fontSize: context.rf(16),
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              fontSize: context.rf(16), color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: context.rs(8)),
                    GestureDetector(
                      onTap: model.pickContentFile,
                      child: Container(
                        height: context.rs(120),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: model.contenterror != null
                                ? Colors.red
                                : Colors.grey.shade300,
                            width: model.contenterror != null ? 1.5 : 1.2,
                          ),
                        ),
                        child: model.selectedcontentfile != null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(context.rs(10)),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF2F6BFF,
                                        ).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.insert_drive_file,
                                        color: const Color(0xFF2F6BFF),
                                        size: context.rs(30),
                                      ),
                                    ),
                                    SizedBox(width: context.rs(12)),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model.selectedfilename ?? '',
                                            style: TextStyle(
                                              fontSize: context.rf(14),
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: context.rs(4)),
                                          Text(
                                            "Tap to change file",
                                            style: TextStyle(
                                              fontSize: context.rf(12),
                                              color: Colors.black38,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: model.removecontentfile,
                                      child: Container(
                                        padding: EdgeInsets.all(context.rs(6)),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: context.rs(18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload_file,
                                    size: context.rs(40),
                                    color: model.contenterror != null
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  SizedBox(height: context.rs(8)),
                                  Text(
                                    "Write & upload your content here",
                                    style: TextStyle(
                                      fontSize: context.rf(14),
                                      color: model.contenterror != null
                                          ? Colors.red
                                          : Colors.black54,
                                    ),
                                  ),
                                  if (model.contenterror != null)
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: context.rs(4)),
                                      child: Text(
                                        model.contenterror!,
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
                    SizedBox(height: context.rs(100)),

                    // ✅ Publish button
                    AppButton(
                      title: "Publish Now",
                      onTap: model.onpublishlesson,
                      isLoading: model.isBusy,
                    ),
                    SizedBox(height: context.rs(30)),
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

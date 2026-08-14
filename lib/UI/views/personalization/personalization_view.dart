import 'package:englify_app/UI/views/personalization/personalization_view_model.dart';
import 'package:englify_app/UI/widgets/app_logo.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PersonalizationView extends StatelessWidget {
  const PersonalizationView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;

    return ViewModelBuilder<PersonalizationViewModel>.reactive(
      viewModelBuilder: () => PersonalizationViewModel(),

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
                    const AppLogo(variant: AppLogoVariant.blue),
                    SizedBox(height: context.rs(isLandscape ? 16 : 24)),
                    Text(
                      "What's your name?",
                      style: TextStyle(
                        fontFamily: "heading",
                        fontSize: context.rf(isLandscape ? 24 : 30),
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: context.rs(8)),
                    Text(
                      "Enter your name so we know what to call you. "
                      "We'll use it to personalize your app and orders.",
                      style: TextStyle(
                        fontSize: context.rf(14),
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: context.rs(isLandscape ? 12 : 15)),
                    Text(
                      "Name",
                      style: TextStyle(
                        fontSize: context.rf(15),
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: context.rs(4)),
                    TextField(
                      cursorColor: Colors.black,
                      controller: model.usernamecontroller,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Enter your name",
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
                      ),
                    ),
                    SizedBox(height: context.rs(isLandscape ? 16 : 20)),
                    AppButton(
                      title: 'Continue',
                      onTap: model.oncontinue,
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
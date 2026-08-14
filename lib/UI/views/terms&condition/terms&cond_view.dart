import 'package:englify_app/UI/views/terms&condition/terms&cond_viewmodel.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TermsandcondView extends StatelessWidget {
  const TermsandcondView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => TermsandcondViewmodel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/dies_logo.png'), // Tumhari image path
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
                child: Padding(padding: EdgeInsets.symmetric(horizontal: context.hPad,vertical: context.rs(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.rs(15),),
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
                            child: Icon(Icons.arrow_back,color: Colors.black,),
                          ),
                        ),
                        Expanded(
                          child:Center(
                            child: Text(
                              "Terms & Conditions",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: context.rf(18),
                              ),
                            ),
                          )
                           ),

                      ],
                    ),
                    SizedBox(height: context.rs(5),),
                    Container(
                            height: 2,
                            width: double.infinity,
                            color: Colors.white54,
                          ),
                          SizedBox(height: context.rs(15),),
                          Expanded(
                            child: SingleChildScrollView(
                              child: ResponsiveContainer(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Terms & Conditions",
                                    style: TextStyle(
                                      fontFamily: "heading",
                                      fontSize: context.rf(30),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                    ),
                                  ),
                                  SizedBox(height: context.rs(8),),
                                  Text(
                                    "By using this application, you agree to comply with and be bound by the following terms and conditions. Please read them carefully.",
                                    style: TextStyle(
                                      fontSize: context.rf(14),
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  _buildSection(
                                    context,
                                    "1. Acceptance of Terms",
                                     "By accessing or using this app, you confirm that you accept these Terms & Conditions. If you do not agree, please do not use the application.",),
                                     _buildSection(
                                context,
                                "2. User Responsibilities",
                                "You agree to use the app only for lawful purposes and in a way that does not violate any applicable laws or regulations.",
                              ),
                              _buildSection(
                                context,
                                "3. Account Information",
                                "You are responsible for maintaining the confidentiality of your account details and for all activities that occur under your account.",
                              ),
                              _buildSection(
                                context,
                                "4. Content Usage",
                                "All content provided in the app is for informational and educational purposes only. Unauthorized copying, distribution, or modification is prohibited.",
                              ),
                              _buildSection(
                                context,
                                "5. Privacy",
                                "Your use of the app is also governed by our Privacy Policy. We are committed to protecting your personal information.",
                              ),
                              _buildSection(
                                context,
                                "6. Limitation of Liability",
                                "We are not liable for any loss, damage, or disruption resulting from the use or inability to use the app.",
                              ),
                              _buildSection(
                                context,
                                "7. Changes to Terms",
                                "We reserve the right to update or modify these Terms & Conditions at any time. Continued use of the app indicates acceptance of the revised terms.",
                              ),
                              _buildSection(
                                context,
                                "8. Termination",
                                "We may suspend or terminate your access to the app if you violate these terms or misuse the platform.",
                              ),
                              _buildSection(
                                context,
                                "9. Contact Us",
                                "If you have any questions about these Terms & Conditions, please contact us through the support section of the app.",
                              ),
                                ],
                              ),
                              )
                            )
                            )
                  ],
                ),
                )

                ),
            ],
          ),
        );
      },
    );
  }
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
            fontWeight: FontWeight.w400
           ),
          ),
          SizedBox(height: context.rs(8)),
          Text(
            content,
            style: TextStyle(
             fontSize: context.rf(14),
             color: Colors.white,
             fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
    );
  }

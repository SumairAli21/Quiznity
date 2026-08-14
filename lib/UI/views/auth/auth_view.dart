import 'package:englify_app/UI/views/auth/auth_view_model.dart';
import 'package:englify_app/UI/widgets/app_logo.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset("assets/images/auth.png", fit: BoxFit.cover),
              ),

              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.15),
                        Colors.black.withOpacity(0.65),
                      ],
                    ),
                  ),
                ),
              ),

              // Logo — kept inside SafeArea so a notch or landscape cutout can
              // never clip it, and aligned to the page gutter rather than a
              // hardcoded 5px offset.
              Positioned.fill(
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: context.hPad,
                        top: context.rs(12),
                      ),
                      child: const AppLogo.header(),
                    ),
                  ),
                ),
              ),

              // Buttons Section
              Positioned(
                left: context.rs(23),
                right: context.rs(23),
                bottom: context.rs(70),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ✅ Apple Sign-In Button
                    SizedBox(
                      width: double.infinity,
                      height: context.rs(52),
                      child: ElevatedButton(
                        onPressed: model.isBusy ? null : model.signInWithApple,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2F6BFF),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (model.isBusy) ...[
                              const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                            ] else ...[
                              Icon(Icons.apple,
                                  size: context.rs(30), color: Colors.white),
                              const SizedBox(width: 12),
                            ],
                            Text(
                              model.isBusy
                                  ? "Signing in..."
                                  : "Continue with Apple",
                              style: TextStyle(
                                fontFamily: "button",
                                fontSize: context.rf(16),
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: context.rs(15)),

                    // ✅ Google Sign-In Button
                    SizedBox(
                      width: double.infinity,
                      height: context.rs(52),
                      child: ElevatedButton(
                        onPressed: model.isBusy ? null : model.signInWithGoogle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (model.isBusy) ...[
                              const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                            ] else ...[
                              FaIcon(
                                FontAwesomeIcons.google,
                                size: context.rs(28),
                                color: Colors.black,
                              ),
                              const SizedBox(width: 12),
                            ],
                            Text(
                              model.isBusy
                                  ? "Signing in..."
                                  : "Continue with Gmail",
                              style: TextStyle(
                                fontFamily: "button",
                                fontSize: context.rf(16),
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: context.rs(15)),

                    // ✅ Email Button
                    SizedBox(
                      width: double.infinity,
                      height: context.rs(52),
                      child: ElevatedButton(
                        onPressed: model.isBusy
                            ? null
                            : model.continuewithemail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email,
                                size: context.rs(30), color: Colors.black),
                            const SizedBox(width: 12),
                            Text(
                              "Continue with Email",
                              style: TextStyle(
                                fontFamily: "button",
                                fontSize: context.rf(16),
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ✅ Error Message Display
                    if (model.errorMessage != null)
                      Padding(
                        padding: EdgeInsets.only(top: context.rs(16)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.rs(16),
                            vertical: context.rs(12),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.red.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red.shade300,
                                size: context.rs(20),
                              ),
                              SizedBox(width: context.rs(12)),
                              Expanded(
                                child: Text(
                                  model.errorMessage!,
                                  style: TextStyle(
                                    color: Colors.red.shade100,
                                    fontSize: context.rf(14),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    SizedBox(height: context.rs(20)),

                    // Terms & Privacy
                    Column(
                      children: [
                        Text(
                          "By continuing you agree to our",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "button",
                            fontSize: context.rf(12),
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.rs(6)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: model.isBusy
                              ? null
                              : model.onnavigatetoprivecy,
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "privacy policy",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "button",
                              fontSize: context.rf(12),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: context.rs(4)),
                        Text("and", style: TextStyle(color: Colors.white70)),
                        SizedBox(width: context.rs(4)),
                        TextButton(
                          onPressed: model.isBusy
                              ? null
                              : model.onnavigatetoterms,
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "Terms of use",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "button",
                              fontSize: context.rf(12),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
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

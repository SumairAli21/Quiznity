import 'package:englify_app/UI/views/login/login_view_model.dart';
import 'package:englify_app/UI/widgets/resuale_email_textfeild.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:englify_app/UI/widgets/reusable_pass_txtfeild.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.rs(24)),
                child: ResponsiveContainer(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.rs(20)),
                    Row(
                      children: [
                        IconButton(
                          onPressed: model.onback,
                          icon: Icon(
                            Icons.arrow_back_sharp,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Sign up with Email",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: context.rf(22),
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: context.rs(48)),
                      ],
                    ),
                    SizedBox(height: context.heightPercent(10)),
                    Text(
                      "Email address",
                      style: TextStyle(
                        fontFamily: "button",
                        fontSize: context.rf(14),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: context.rs(5)),
                    ResualeEmailTextfeild(
                      onchange: model.onemailchage,
                      emailcontroller: model.emailcontroller,
                      errortext: model.errormasage,
                    ),
                    SizedBox(height: context.rs(10)),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontFamily: "buton",
                        fontSize: context.rf(14),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: context.rs(5)),
                    ReusablePassTxtfeild(
                      isobscue: model.isobsurce,
                      onchnage: model.onpasschage,
                      passcontroller: model.passwordcontroller,
                      toggle: model.toggle,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: model.onforgate,
                        child: Text(
                          "Forget Password",
                          style: TextStyle(
                            fontFamily: "button",
                            fontSize: context.rf(12),
                            color: const Color.fromARGB(255, 249, 247, 247),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.rs(10)),
                     SizedBox(
      width: double.infinity,
      height: context.rs(52),
      child: ElevatedButton(
        onPressed: model.isBusy ? null : () => model.onlogin(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F6BFF),
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
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Text(
              "Login",
              style: TextStyle(
                fontFamily: "button",
                fontSize: context.rf(18),
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
                    SizedBox(height: context.rs(20)),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "I don't have an account? ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: "button",
                                fontSize: context.rf(14),
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: model.onsignout,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              "Sign out",
                              style: TextStyle(
                                fontFamily: "button",
                                fontSize: context.rf(14),
                                color: const Color.fromARGB(255, 249, 247, 247),
                              ),
                            ),
                          ),
                        ],
                      ),
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

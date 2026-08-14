import 'package:englify_app/UI/views/signup/signup_password_view_model.dart';
import 'package:englify_app/UI/widgets/reusable_condition_tile.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:englify_app/UI/widgets/reusable_pass_txtfeild.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignupPasswordView extends StatelessWidget {
  String email;
  SignupPasswordView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupPasswordViewModel>.reactive(
      viewModelBuilder: () => SignupPasswordViewModel(email:email),
      onModelReady: (model) => model.init(),
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
                      "Password",
                      style: TextStyle(
                        fontFamily: "buton",
                        fontSize: context.rf(14),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: context.rs(5)),
                    ReusablePassTxtfeild(
                      isobscue: model.isobscure,
                      onchnage: model.onchangepass,
                      passcontroller: model.passwordcontroller,
                      toggle: model.togglevisibality,
                    ),
                    SizedBox(height: context.rs(12)),
                    ReusableConditionTile(
                      isvalid: model.hasminilenght,
                      txt: "At least 8 cherecters",
                    ),
                    ReusableConditionTile(
                      isvalid: model.hasuppercase,
                      txt: "At least 1 uppercase letter",
                    ),
                    ReusableConditionTile(
                      isvalid: model.haslowercase,
                      txt: "At least 1 lowercase letter",
                    ),
                    ReusableConditionTile(
                      isvalid: model.hasnumber,
                      txt: "At least 1 number",
                    ),
                    SizedBox(height: context.rs(25)),
                    AppButton(
                      title: "Create account",
                      isLoading: model.isBusy,
                      onTap: () => model.oncreate(context),
                    ),
                    SizedBox(height: context.rs(17)),
                    Column(
                      children: [
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            Text(
                              'By creating an account, you agree to the ',
                              style: TextStyle(
                                fontFamily: "button",
                                fontSize: context.rf(12),
                                color: Colors.white60,
                              ),
                            ),
                            TextButton(
                              onPressed:model.onnavigatetoterms,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Terms of Service',
                                style: TextStyle(
                                  fontFamily: "button",
                                  fontSize: context.rf(12),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            Text(
                              'and ',
                              style: TextStyle(
                                fontFamily: "button",
                                fontSize: context.rf(12),
                                color: Colors.white60,
                              ),
                            ),
                            TextButton(
                              onPressed: model.onnavigatetoprivecy,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Privacy Policy',
                                style: TextStyle(
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

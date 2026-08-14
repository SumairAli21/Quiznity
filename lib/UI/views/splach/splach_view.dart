import 'package:englify_app/UI/views/splach/splach_view_model.dart';
import 'package:englify_app/UI/widgets/app_logo.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SplachView extends StatelessWidget {
  const SplachView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SplachViewModel(),
      onModelReady: (model) => model.runsetuplogic(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Center(
              // Padding keeps the wordmark off the edges on very narrow
              // phones; AppLogo caps its own width above that.
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.hPad),
                child: const AppLogo.splash(),
              ),
            ),
          ),
        );
      },
    );
  }
}

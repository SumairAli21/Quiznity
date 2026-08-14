import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';

class OnbordingSlides extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback oncontinue;
  final VoidCallback onskip;
  final int currentIndex;
  final int totalPages;

  const OnbordingSlides({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.oncontinue,
    required this.onskip,
    required this.currentIndex,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final isLandscape = context.isLandscape;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: isLandscape
            ? _buildLandscapeLayout(context, size)
            : _buildPortraitLayout(context, size),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context, Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Section with Skip Button
        Stack(
          children: [
            Image.asset(
              image,
              width: size.width,
              height: size.height * 0.64,
              fit: BoxFit.cover,
            ),
            // Skip Button (hidden on the last onboarding screen)
            if (currentIndex != totalPages - 1)
              Positioned(
                top: context.rs(16),
                right: context.rs(16),
                child: GestureDetector(
                  onTap: onskip,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: context.rs(6),
                      horizontal: context.rs(14),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: context.rf(14),
                        color: Colors.white,
                        fontFamily: "button",
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),

        // Content Section
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.rs(20), vertical: context.rs(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontFamily: "heading",
                    fontSize: context.rf(24),
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: context.rs(12)),

                // Subtitle
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: "button",
                    fontSize: context.rf(14),
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),

                // Guaranteed minimum spacing between body text and the CTA
                // cluster so they never crowd on short screens, while the
                // Spacer still anchors the button toward the bottom.
                SizedBox(height: context.rs(32)),
                Spacer(),

                // ✅ Page Indicators
                _buildPageIndicators(context),
                SizedBox(height: context.rs(16)),

                // Continue Button
                AppButton(
                  title: currentIndex == totalPages - 1
                      ? "Get Started"
                      : "Continue",
                  onTap: oncontinue,
                ),
                SizedBox(height: context.rs(8)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context, Size size) {
    return Row(
      children: [
        // Image Section
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              Image.asset(
                image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              // Skip Button (hidden on the last onboarding screen)
              if (currentIndex != totalPages - 1)
                Positioned(
                  top: context.rs(16),
                  right: context.rs(16),
                  child: GestureDetector(
                    onTap: onskip,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: context.rs(6),
                        horizontal: context.rs(14),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: context.rf(14),
                          color: Colors.white,
                          fontFamily: "button",
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Content Section
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(context.rs(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontFamily: "heading",
                    fontSize: context.rf(20),
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: context.rs(12)),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: "button",
                    fontSize: context.rf(13),
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: context.rs(24)),

                // ✅ Page Indicators
                _buildPageIndicators(context),
                SizedBox(height: context.rs(16)),

                AppButton(
                  title: currentIndex == totalPages - 1
                      ? "Get Started"
                      : "Continue",
                  onTap: oncontinue,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ✅ Page Indicator Dots
  Widget _buildPageIndicators(BuildContext context) {
    return Row(
      children: List.generate(
        totalPages,
        (index) => Container(
          margin: EdgeInsets.only(right: context.rs(8)),
          width: currentIndex == index ? context.rs(24) : context.rs(8),
          height: context.rs(8),
          decoration: BoxDecoration(
            color: currentIndex == index
                ? Color(0xFF2F6BFF)
                : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
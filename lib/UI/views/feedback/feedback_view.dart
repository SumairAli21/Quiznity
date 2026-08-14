import 'package:englify_app/UI/views/feedback/feedback_viewmodel.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedbackViewmodel>.reactive(
      viewModelBuilder: () => FeedbackViewmodel(), 
      builder: (context,model,child)
{
  return Scaffold(
          body: Stack(
            children: [
              // Background
              Positioned.fill(
                child: Image.asset(
                  'assets/images/sky_bg.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.35),
                ),
              ),

              SafeArea(
                child: Column(
                  children: [
                    // Top bar
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.rs(20),
                          vertical: context.rs(14)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: model.onBack,
                            child: Container(
                              padding: EdgeInsets.all(context.rs(8)),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.arrow_back,
                                  color: const Color(0xFF2F6BFF),
                                  size: context.rs(20)),
                            ),
                          ),
                          SizedBox(width: context.rs(14)),
                          Text(
                            'Feedback',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: context.rf(24),
                              fontWeight: FontWeight.w800,
                              fontFamily: 'heading',
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.rs(20)),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: context.rs(8)),

                            // Main card
                            Container(
                              padding: EdgeInsets.all(context.rs(20)),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.93),
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 16,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header
                                  Text(
                                    'Share your thoughts 💬',
                                    style: TextStyle(
                                      fontSize: context.rf(18),
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: context.rs(4)),
                                  Text(
                                    'Your feedback helps us improve Quiznity!',
                                    style: TextStyle(
                                      fontSize: context.rf(13),
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: context.rs(20)),

                                  // Rating
                                  Text(
                                    'Rate your experience',
                                    style: TextStyle(
                                      fontSize: context.rf(14),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: context.rs(10)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: List.generate(5, (i) {
                                      final star = i + 1;
                                      return GestureDetector(
                                        onTap: () =>
                                            model.setRating(star),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: context.rs(6)),
                                          child: Icon(
                                            model.selectedRating >= star
                                                ? Icons.star_rounded
                                                : Icons.star_outline_rounded,
                                            color: model.selectedRating >=
                                                    star
                                                ? const Color(0xFFFFD700)
                                                : Colors.grey[400],
                                            size: context.rs(38),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  SizedBox(height: context.rs(20)),

                                  // Name field
                                  _buildLabel(context, 'Your Name *'),
                                  SizedBox(height: context.rs(6)),
                                  _buildTextField(
                                    context: context,
                                    controller: model.nameController,
                                    hint: 'Enter your name',
                                    icon: Icons.person_outline,
                                  ),
                                  SizedBox(height: context.rs(14)),

                                  // Email field
                                  _buildLabel(context, 'Your Email (optional)'),
                                  SizedBox(height: context.rs(6)),
                                  _buildTextField(
                                    context: context,
                                    controller: model.emailController,
                                    hint: 'Enter your email',
                                    icon: Icons.email_outlined,
                                    keyboardType:
                                        TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: context.rs(14)),

                                  // Message field
                                  _buildLabel(context, 'Your Feedback *'),
                                  SizedBox(height: context.rs(6)),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius:
                                          BorderRadius.circular(14),
                                      border: Border.all(
                                          color: Colors.grey[200]!),
                                    ),
                                    child: TextField(
                                      controller: model.messageController,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        hintText:
                                            'Tell us what you think...',
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: context.rf(14)),
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.all(context.rs(14)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: context.rs(24)),

                                  // Submit button
                                  SizedBox(
                                    width: double.infinity,
                                    height: context.rs(52),
                                    child: ElevatedButton(
                                      onPressed: model.isBusy
                                          ? null
                                          : model.submitFeedback,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF2F6BFF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: model.isBusy
                                          ? SizedBox(
                                              width: context.rs(22),
                                              height: context.rs(22),
                                              child:
                                                  const CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Text(
                                              'Submit Feedback',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: context.rf(16),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: context.rs(30)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
}      );
  }

   Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: context.rf(14),
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        cursorColor: Colors.black,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              TextStyle(color: Colors.grey[400], fontSize: context.rf(14)),
          prefixIcon: Icon(icon, color: Colors.grey[400], size: context.rs(20)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
              horizontal: context.rs(14), vertical: context.rs(14)),
        ),
      ),
    );
  }
}
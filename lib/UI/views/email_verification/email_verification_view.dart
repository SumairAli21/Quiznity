import 'package:englify_app/UI/views/email_verification/email_verification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class EmailVerificationView extends StatelessWidget {
  const EmailVerificationView({super.key});

  static const _blue = Color(0xFF2F6BFF);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return ViewModelBuilder<EmailVerificationViewModel>.reactive(
      onViewModelReady: (model) => model.init(),
      viewModelBuilder: () => EmailVerificationViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/dies_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.2)),
              ),
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 48 : 20,
                    ),
                    child: _buildCard(model, isTablet),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCard(EmailVerificationViewModel model, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 32 : 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.mark_email_unread_outlined,
                color: _blue, size: 48),
          ),
          const SizedBox(height: 20),
          Text(
            'Verify Your Email',
            style: TextStyle(
              fontSize: isTablet ? 24 : 20,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              fontFamily: 'heading',
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'We sent a verification link to\n${model.email}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 15 : 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Open the link, then come back and tap "I\'ve Verified".',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 13 : 12,
              color: Colors.grey[400],
              height: 1.4,
            ),
          ),

          if (model.errorMessage != null) ...[
            const SizedBox(height: 16),
            _message(model.errorMessage!, Colors.red, Icons.error_outline),
          ],
          if (model.infoMessage != null) ...[
            const SizedBox(height: 16),
            _message(
                model.infoMessage!, Colors.green, Icons.check_circle_outline),
          ],

          const SizedBox(height: 24),

          // Primary: check verified
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: model.isBusy ? null : () => model.checkVerified(),
              child: model.isBusy
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      "I've Verified",
                      style: TextStyle(
                        fontSize: isTablet ? 17 : 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 12),

          // Secondary: resend (with cooldown)
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: _blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: model.canResend ? model.resend : null,
              child: Text(
                model.resendCooldown > 0
                    ? 'Resend in ${model.resendCooldown}s'
                    : 'Resend Email',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: _blue,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          GestureDetector(
            onTap: model.useDifferentAccount,
            child: Text(
              'Use a different account',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _message(String text, Color color, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text, style: TextStyle(color: color, fontSize: 13)),
        ),
      ],
    );
  }
}

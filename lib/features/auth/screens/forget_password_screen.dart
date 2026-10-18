import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/auth_layout.dart';
import 'verification_code_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Forget Password!',
      subtitle: 'Enter your registered email below',
      children: [
        const AppTextField(
          label: 'Email address',
          hint: 'jodeyinka@example.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text(
              'Remember the password?',
              style: TextStyle(fontSize: 16, color: AppColors.subtitle),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        PrimaryButton(
          text: 'Send Code',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VerificationCodeScreen()),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/auth_layout.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  final String role;
  const LoginScreen({super.key, this.role = ''});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Log In',
      subtitle: 'Please enter your email and password below!',
      children: [
        const AppTextField(
          label: 'Email address',
          hint: 'jodeyinka@example.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        const AppTextField(
          label: 'Password',
          hint: 'Aslijk237hjh%^*****',
          isPassword: true,
        ),
        const SizedBox(height: 14),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ForgetPasswordScreen()),
            ),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(fontSize: 16, color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(height: 24),
        PrimaryButton(text: 'Log In', onPressed: () {}),
        const SizedBox(height: 16),
        OutlineButtonX(text: 'Sign Up', onPressed: () {}),
      ],
    );
  }
}

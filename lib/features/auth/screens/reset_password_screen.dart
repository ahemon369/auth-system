import 'package:flutter/material.dart';

import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/auth_layout.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Change New Password!',
      subtitle: 'Enter a different password with the previous!',
      children: [
        const AppTextField(
          label: 'New Password',
          hint: 'Aslijk237hjh%^*****',
          isPassword: true,
        ),
        const SizedBox(height: 16),
        const AppTextField(
          label: 'Confirm assword',
          hint: 'Aslijk237hjh%^*****',
          isPassword: true,
        ),
        const SizedBox(height: 32),
        PrimaryButton(
          text: 'Reset Password',
          onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
        ),
      ],
    );
  }
}

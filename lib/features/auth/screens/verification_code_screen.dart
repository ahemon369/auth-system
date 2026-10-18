import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/auth_layout.dart';
import 'reset_password_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  static const _length = 6;

  final _controllers = List.generate(_length, (_) => TextEditingController());
  final _nodes = List.generate(_length, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < _length - 1) {
      _nodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _nodes[index - 1].requestFocus();
    }
  }

  Widget _codeBox(int index) {
    OutlineInputBorder border(Color color) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: color),
        );

    return SizedBox(
      width: 48,
      height: 48,
      child: TextField(
        controller: _controllers[index],
        focusNode: _nodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        onChanged: (v) => _onChanged(index, v),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          enabledBorder: border(AppColors.border),
          focusedBorder: border(AppColors.primary),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      maxWidth: 470,
      title: 'Verification Code',
      subtitleWidget: const Text.rich(
        TextSpan(
          style: TextStyle(fontSize: 16, color: AppColors.subtitle),
          children: [
            TextSpan(text: 'We have sent a verification code to your '),
            TextSpan(
              text: 'support@gmail.com',
              style: TextStyle(
                color: AppColors.linkTeal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < _length; i++) ...[
              if (i != 0) const SizedBox(width: 12),
              _codeBox(i),
            ],
          ],
        ),
        const SizedBox(height: 32),
        PrimaryButton(
          text: 'Verify',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't receive the code?",
              style: TextStyle(fontSize: 16, color: AppColors.hint),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Resent',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

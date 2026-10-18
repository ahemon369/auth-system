import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

const _buttonTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
final _buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: _buttonShape,
        ),
        child: Text(text, style: _buttonTextStyle),
      ),
    );
  }
}

class OutlineButtonX extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color background;

  const OutlineButtonX({
    super.key,
    required this.text,
    required this.onPressed,
    this.background = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: AppColors.outlineText,
          side: const BorderSide(color: AppColors.border),
          shape: _buttonShape,
        ),
        child: Text(text, style: _buttonTextStyle),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Common centered layout used by every auth screen.
class AuthLayout extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final List<Widget> children;
  final double maxWidth;

  const AuthLayout({
    super.key,
    required this.title,
    this.subtitle,
    this.subtitleWidget,
    required this.children,
    this.maxWidth = 550,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.title,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  subtitleWidget ??
                      Text(
                        subtitle ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, color: AppColors.subtitle),
                      ),
                  const SizedBox(height: 32),
                  ...children,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

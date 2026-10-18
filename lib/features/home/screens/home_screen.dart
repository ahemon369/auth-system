import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../auth/screens/role_select_screen.dart';

class HomeScreen extends StatelessWidget {
  final String role;
  const HomeScreen({super.key, this.role = ''});

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const RoleSelectScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(
            color: AppColors.title,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 550),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.check_circle_rounded,
                      size: 72, color: AppColors.primary),
                  const SizedBox(height: 16),
                  const Text(
                    'Welcome!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.title,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    role.isEmpty
                        ? 'You are logged in.'
                        : 'You are logged in as $role.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, color: AppColors.subtitle),
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                      text: 'Log Out', onPressed: () => _logout(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

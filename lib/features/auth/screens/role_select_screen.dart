import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/auth_layout.dart';
import 'login_screen.dart';

class RoleSelectScreen extends StatelessWidget {
  const RoleSelectScreen({super.key});

  static const _roles = ['Tenant', 'Landlord', 'Vendor'];

  void _openLogin(BuildContext context, String role) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen(role: role)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Log In',
      subtitle: 'Please enter your email and password below!',
      children: [
        for (int i = 0; i < _roles.length; i++) ...[
          if (i != 0) const SizedBox(height: 16),
          OutlineButtonX(
            text: 'Log In as ${_roles[i]}',
            background: AppColors.roleButtonBg,
            onPressed: () => _openLogin(context, _roles[i]),
          ),
        ],
      ],
    );
  }
}

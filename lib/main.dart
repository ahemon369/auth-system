import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

// ---------- Theme constants ----------
const kPrimary = Color(0xFF05606B);
const kTitle = Color(0xFF141414);
const kSubtitle = Color(0xFF555555);
const kBorder = Color(0xFFE6E6E6);
const kHint = Color(0xFF7A7A7A);
const kLinkTeal = Color(0xFF2E7D8A);
const kRoleBg = Color(0xFFFAFAFA);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth UI',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimary),
      ),
      home: const RoleSelectScreen(),
    );
  }
}

// ---------- Shared widgets ----------
class AuthLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final double maxWidth;

  const AuthLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.maxWidth = 550,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                      color: kTitle,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: kSubtitle),
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

class AppTextField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.controller,
    this.keyboardType,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  OutlineInputBorder _border() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: kBorder),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: const TextStyle(fontSize: 16, color: Colors.black)),
        const SizedBox(height: 10),
        SizedBox(
          height: 48,
          child: TextField(
            controller: widget.controller,
            obscureText: widget.isPassword && _obscure,
            keyboardType: widget.keyboardType,
            style: const TextStyle(fontSize: 14, color: kTitle),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(fontSize: 14, color: kHint),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              enabledBorder: _border(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: kPrimary),
              ),
              border: _border(),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: kHint,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

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
          backgroundColor: kPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class OutlineBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color background;
  const OutlineBtn({
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
          foregroundColor: const Color(0xFF444444),
          side: const BorderSide(color: kBorder),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

// ---------- Screen 1: Role select ----------
class RoleSelectScreen extends StatelessWidget {
  const RoleSelectScreen({super.key});

  void _go(BuildContext context, String role) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => LoginScreen(role: role)));
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Log In',
      subtitle: 'Please enter your email and password below!',
      children: [
        OutlineBtn(
            text: 'Log In as Tenant',
            background: kRoleBg,
            onPressed: () => _go(context, 'Tenant')),
        const SizedBox(height: 16),
        OutlineBtn(
            text: 'Log In as Landlord',
            background: kRoleBg,
            onPressed: () => _go(context, 'Landlord')),
        const SizedBox(height: 16),
        OutlineBtn(
            text: 'Log In as Vendor',
            background: kRoleBg,
            onPressed: () => _go(context, 'Vendor')),
      ],
    );
  }
}

// ---------- Screen 2: Log In ----------
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
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ForgetPasswordScreen())),
            child: const Text('Forgot Password?',
                style: TextStyle(fontSize: 16, color: kPrimary)),
          ),
        ),
        const SizedBox(height: 24),
        PrimaryButton(text: 'Log In', onPressed: () {}),
        const SizedBox(height: 16),
        OutlineBtn(text: 'Sign Up', onPressed: () {}),
      ],
    );
  }
}

// ---------- Screen 3: Forget Password ----------
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
            const Text('Remember the password?',
                style: TextStyle(fontSize: 16, color: kSubtitle)),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 16,
                  color: kPrimary,
                  decoration: TextDecoration.underline,
                  decorationColor: kPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        PrimaryButton(
          text: 'Send Code',
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const VerificationCodeScreen())),
        ),
      ],
    );
  }
}

// ---------- Screen 4: Verification Code ----------
class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _nodes = List.generate(6, (_) => FocusNode());

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

  void _onChanged(int i, String v) {
    if (v.isNotEmpty && i < 5) {
      _nodes[i + 1].requestFocus();
    } else if (v.isEmpty && i > 0) {
      _nodes[i - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      maxWidth: 470,
      title: 'Verification Code',
      subtitle: '',
      children: const [],
    ).buildWith(context, this);
  }
}

// Helper so the verification screen can reuse AuthLayout with a custom subtitle.
extension on AuthLayout {
  Widget buildWith(BuildContext context, _VerificationCodeScreenState s) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 470),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Verification Code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: kTitle,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 16, color: kSubtitle),
                      children: [
                        TextSpan(text: 'We have sent a verification code to your '),
                        TextSpan(
                          text: 'support@gmail.com',
                          style: TextStyle(
                              color: kLinkTeal, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (i) {
                      return Padding(
                        padding: EdgeInsets.only(left: i == 0 ? 0 : 12),
                        child: SizedBox(
                          width: 48,
                          height: 48,
                          child: TextField(
                            controller: s._controllers[i],
                            focusNode: s._nodes[i],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                            onChanged: (v) => s._onChanged(i, v),
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(color: kBorder),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(color: kPrimary),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    text: 'Verify',
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ResetPasswordScreen())),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't receive the code?",
                          style: TextStyle(fontSize: 16, color: kHint)),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {},
                        child: const Text('Resent',
                            style: TextStyle(
                                fontSize: 16,
                                color: kPrimary,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- Screen 5: Reset Password ----------
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
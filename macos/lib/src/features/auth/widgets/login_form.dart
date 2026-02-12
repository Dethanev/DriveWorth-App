import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/app_colors.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final ValueChanged<String> onEmailChanged;
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.onEmailChanged,
    required this.onLoginPressed,
    required this.onRegisterPressed,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isPasswordVisible = false;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: widget.emailController,
            focusNode: widget.emailFocusNode,
            onChanged: widget.onEmailChanged,
            keyboardType: TextInputType.emailAddress,
            style: GoogleFonts.poppins(fontSize: 14),
            decoration: _inputDecoration("電子郵件", Icons.email_outlined),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: widget.passwordController,
            focusNode: widget.passwordFocusNode,
            obscureText: !_isPasswordVisible,
            style: GoogleFonts.poppins(fontSize: 14),
            decoration: _inputDecoration(
              "密碼",
              Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    activeColor: AppColors.socialButtonPrimary,
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() => _isChecked = value!);
                    },
                  ),
                  Text("記住我", style: GoogleFonts.poppins(fontSize: 12)),
                ],
              ),
              ElevatedButton(
                onPressed: widget.onLoginPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.socialButtonPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  "登入",
                  style: GoogleFonts.poppins(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          TextButton(
            onPressed: widget.onRegisterPressed,
            child: Text(
              '建立帳號',
              style: GoogleFonts.poppins(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon, {
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: AppColors.socialButtonPrimary),
      suffixIcon: suffixIcon,
      labelText: label,
      filled: true,
      fillColor: AppColors.analyzeInputBackground,
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
      floatingLabelStyle: const TextStyle(
        color: AppColors.socialButtonPrimary,
        fontSize: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.socialButtonPrimary, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

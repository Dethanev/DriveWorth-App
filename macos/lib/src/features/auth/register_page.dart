import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import '../../config/app_colors.dart';
import '../../data/supabase/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _avatarUrlController = TextEditingController();

  final _nicknameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  StateMachineController? stateMachineController;
  SMITrigger? successTrigger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? numLook;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_onEmailFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
    _confirmPasswordFocusNode.addListener(_onConfirmPasswordFocusChange);
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _avatarUrlController.dispose();
    _nicknameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    stateMachineController?.dispose();
    super.dispose();
  }

  void _onRiveInit(Artboard artboard) {
    stateMachineController = StateMachineController.fromArtboard(
      artboard,
      "State Machine 1",
    );
    if (stateMachineController != null) {
      artboard.addController(stateMachineController!);
      for (var input in stateMachineController!.inputs) {
        if (input.name == "success") {
          successTrigger = input as SMITrigger;
        } else if (input.name == "fail") {
          failTrigger = input as SMITrigger;
        } else if (input.name == "hands_up") {
          isHandsUp = input as SMIBool;
        } else if (input.name == "Check") {
          isChecking = input as SMIBool;
        } else if (input.name == "Look") {
          numLook = input as SMINumber;
        }
      }
    }
  }

  void _onEmailFocusChange() {
    if (_emailFocusNode.hasFocus) {
      isChecking?.value = true;
      isHandsUp?.value = false;
    } else if (!_passwordFocusNode.hasFocus &&
        !_confirmPasswordFocusNode.hasFocus) {
      isChecking?.value = false;
      isHandsUp?.value = false;
    }
  }

  void _onPasswordFocusChange() {
    if (_passwordFocusNode.hasFocus || _confirmPasswordFocusNode.hasFocus) {
      isHandsUp?.value = true;
      isChecking?.value = false;
    } else if (!_emailFocusNode.hasFocus) {
      isHandsUp?.value = false;
      isChecking?.value = false;
    }
  }

  void _onConfirmPasswordFocusChange() {
    _onPasswordFocusChange();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await AuthService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (response.user != null) {
        await AuthService.createProfile(
          userId: response.user!.id,
          nickname: _nicknameController.text.trim(),
          avatarUrl:
              _avatarUrlController.text.trim().isEmpty
                  ? null
                  : _avatarUrlController.text.trim(),
        );

        if (!mounted) return;
        successTrigger?.fire();
        _showSuccess('註冊成功！');
        Future.delayed(const Duration(seconds: 2), () {
          if (!mounted) return;
          Navigator.pop(context);
        });
      }
    } catch (e) {
      if (!mounted) return;
      failTrigger?.fire();
      _showError('註冊失敗：${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('錯誤'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.socialButtonPrimary,
                ),
                child: const Text('確定'),
              ),
            ],
          ),
    );
  }

  void _showSuccess(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('成功'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.socialButtonPrimary,
                ),
                child: const Text('確定'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      appBar: AppBar(
        backgroundColor: AppColors.loginBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '建立帳號',
          style: GoogleFonts.poppins(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: RiveAnimation.asset(
                  'assets/animations/bear_login.riv',
                  fit: BoxFit.contain,
                  onInit: _onRiveInit,
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTextField(
                        controller: _nicknameController,
                        label: '暱稱',
                        icon: Icons.person_outline,
                        focusNode: _nicknameFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '請輸入暱稱';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _emailController,
                        label: '電子郵件',
                        icon: Icons.email_outlined,
                        focusNode: _emailFocusNode,
                        keyboardType: TextInputType.emailAddress,
                        onChanged:
                            (val) => numLook?.value = val.length.toDouble(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '請輸入電子郵件';
                          }
                          if (!value.contains('@')) {
                            return '請輸入有效的電子郵件';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _passwordController,
                        label: '密碼',
                        icon: Icons.lock_outline,
                        focusNode: _passwordFocusNode,
                        obscureText: !_isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {
                            setState(
                              () => _isPasswordVisible = !_isPasswordVisible,
                            );
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '請輸入密碼';
                          }
                          if (value.length < 6) {
                            return '密碼長度至少需要 6 個字元';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _confirmPasswordController,
                        label: '確認密碼',
                        icon: Icons.lock_outline,
                        focusNode: _confirmPasswordFocusNode,
                        obscureText: !_isConfirmPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {
                            setState(
                              () =>
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible,
                            );
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '請確認密碼';
                          }
                          if (value != _passwordController.text) {
                            return '密碼不一致';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _handleRegister,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.socialButtonPrimary,
                          disabledBackgroundColor: AppColors.textSecondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child:
                            _isLoading
                                ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.white,
                                    ),
                                  ),
                                )
                                : Text(
                                  '建立帳號',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    FocusNode? focusNode,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      style: GoogleFonts.poppins(fontSize: 14),
      decoration: InputDecoration(
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
          borderSide: BorderSide(
            color: AppColors.socialButtonPrimary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

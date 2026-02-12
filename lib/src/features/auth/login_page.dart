import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:drive_worth/src/layout/app_shell.dart';
import 'package:drive_worth/src/config/app_colors.dart';
import 'package:drive_worth/src/data/supabase/auth_service.dart';
import 'widgets/login_social_section.dart';
import 'widgets/login_form.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Rive 動畫控制器
  StateMachineController? stateMachineController;
  SMITrigger? successTrigger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? numLook;

  // 表單控制器（由 Page 管理以便連動動畫）
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 綁定焦點監聽器以控制動畫
    _emailFocusNode.addListener(_onEmailFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  // Rive 動畫初始化
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
    } else if (!_passwordFocusNode.hasFocus) {
      isChecking?.value = false;
      isHandsUp?.value = false;
    }
  }

  void _onPasswordFocusChange() {
    if (_passwordFocusNode.hasFocus) {
      isHandsUp?.value = true;
      isChecking?.value = false;
    } else if (!_emailFocusNode.hasFocus) {
      isHandsUp?.value = false;
      isChecking?.value = false;
    }
  }

  void _onSocialLoginPressed(String provider) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('$provider 登入'),
            content: const Text('此功能開發中'),
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

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      failTrigger?.fire();
      _showError('請輸入電子郵件和密碼');
      return;
    }

    isChecking?.value = false;
    isHandsUp?.value = false;

    try {
      await AuthService.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;
      successTrigger?.fire();
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RootShell()),
        );
      });
    } catch (e) {
      failTrigger?.fire();
      _showError('登入失敗：${e.toString()}');
    }
  }

  void _showError(String message) {
    if (!mounted) return;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      appBar: AppBar(
        backgroundColor: AppColors.loginBackground,
        elevation: 0,
        centerTitle: true,
        title: Text(
          ' ',
          style: GoogleFonts.poppins(
            color: AppColors.black,
            fontWeight: FontWeight.normal,
            fontSize: 24,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 325,
                width: 325,
                child: RiveAnimation.asset(
                  'assets/animations/bear_login.riv',
                  fit: BoxFit.contain,
                  onInit: _onRiveInit,
                ),
              ),

              LoginForm(
                emailController: _emailController,
                passwordController: _passwordController,
                emailFocusNode: _emailFocusNode,
                passwordFocusNode: _passwordFocusNode,
                onEmailChanged:
                    (val) => numLook?.value = val.length.toDouble(), // 控制動畫眼球移動
                onLoginPressed: _handleLogin,
                onRegisterPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 60),

              Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  children: [
                    const SocialDivider(),
                    const SizedBox(height: 24),
                    LoginSocialSection(
                      onSocialLoginPressed: (provider) {
                        // TODO: 連接第三方登入 API (Apple/Google)
                        _onSocialLoginPressed(provider);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

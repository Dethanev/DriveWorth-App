import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_styles.dart';

class SocialDivider extends StatelessWidget {
  const SocialDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final dividerColor = AppColors.textSecondary.withValues(alpha: 0.2);

    return Row(
      children: [
        Expanded(child: Divider(color: dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('其他登入方式', style: AppTextStyles.caption),
        ),
        Expanded(child: Divider(color: dividerColor)),
      ],
    );
  }
}

class LoginSocialSection extends StatelessWidget {
  final ValueChanged<String> onSocialLoginPressed;

  const LoginSocialSection({super.key, required this.onSocialLoginPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          icon: Icons.apple,
          iconColor: AppColors.white,
          backgroundColor: AppColors.socialButtonPrimary,
          onTap: () => onSocialLoginPressed('Apple'),
        ),
        const SizedBox(width: 24),
        _SocialButton(
          icon: Icons.g_mobiledata_rounded,
          iconColor: AppColors.socialButtonPrimary,
          backgroundColor: AppColors.white,
          hasBorder: true,
          iconSize: 32,
          onTap: () => onSocialLoginPressed('Google'),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final bool hasBorder;
  final VoidCallback onTap;
  final double iconSize;

  const _SocialButton({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.onTap,
    this.hasBorder = false,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      elevation: hasBorder ? 0 : 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border:
                hasBorder
                    ? Border.all(color: AppColors.socialButtonBorder, width: 1)
                    : null,
          ),
          child: Center(child: Icon(icon, color: iconColor, size: iconSize)),
        ),
      ),
    );
  }
}

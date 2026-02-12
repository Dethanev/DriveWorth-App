import 'package:flutter/material.dart';
import '../../../config/app_text_styles.dart';
import '../../../config/app_colors.dart';

class SettingsListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const SettingsListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: AppTextStyles.body),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
            )
          : null,
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}

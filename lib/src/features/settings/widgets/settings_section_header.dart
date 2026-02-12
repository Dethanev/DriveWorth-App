import 'package:flutter/material.dart';
import '../../../config/app_text_styles.dart';

class SettingsSectionHeader extends StatelessWidget {
  final String title;

  const SettingsSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8),
      child: Text(
        title,
        style: AppTextStyles.h2.copyWith(fontSize: 18),
      ),
    );
  }
}

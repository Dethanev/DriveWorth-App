import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_config.dart';

class SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const SettingsCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppConfig.neuStyle(color: AppColors.white),
      child: Column(children: children),
    );
  }
}

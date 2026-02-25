import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';

class AnalyzeHistorySheet extends StatelessWidget {
  const AnalyzeHistorySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: AppConfig.neuStyle(color: AppColors.neuBackground).copyWith(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('試算紀錄', style: AppTextStyles.h3),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Center(
              child: Text(
                'TCO 試算紀錄即將推出',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../models/analysis_record.dart';

class StatusBadge extends StatelessWidget {
  final RiskLevel level;

  const StatusBadge({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (level) {
      case RiskLevel.safe:
        color = AppColors.statusSafe;
        text = '安全';
        break;
      case RiskLevel.suspicious:
        color = AppColors.statusSuspicious;
        text = '可疑';
        break;
      case RiskLevel.danger:
        color = AppColors.statusDanger;
        text = '高風險';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

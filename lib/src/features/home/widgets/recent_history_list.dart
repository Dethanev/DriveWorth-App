import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_styles.dart';
import '../../../shared/models/analysis_record.dart';
import '../../../shared/widgets/status_badge.dart';

class RecentHistoryList extends StatelessWidget {
  const RecentHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final recentRecords = dummyAnalysisRecords.take(3).toList();

    return Column(
      children: recentRecords.map((record) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFF2F2F0),
              child: Icon(
                _getIconByType(record.type),
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
            title: Text(
              record.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyBold,
            ),
            subtitle: Text(
              _getTimeAgo(record.createdAt),
              style: AppTextStyles.caption,
            ),
            trailing: StatusBadge(level: record.riskLevel),
          ),
        );
      }).toList(),
    );
  }
}

IconData _getIconByType(String type) {
  switch (type) {
    case '電話':
      return Icons.phone_rounded;
    case '網址':
      return Icons.public_rounded;
    case '文字':
      return Icons.article_rounded;
    case '圖片':
      return Icons.image_rounded;
    default:
      return Icons.help_outline_rounded;
  }
}

String _getTimeAgo(DateTime date) {
  final diff = DateTime.now().difference(date);

  if (diff.inMinutes < 60) {
    return '${diff.inMinutes} 分鐘前';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} 小時前';
  } else {
    return '${diff.inDays} 天前';
  }
}


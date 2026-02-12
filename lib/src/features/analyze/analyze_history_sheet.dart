import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../shared/models/analysis_record.dart';
import '../../shared/widgets/status_badge.dart';

class AnalyzeHistorySheet extends StatelessWidget {
  const AnalyzeHistorySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
              child: Text('歷史紀錄', style: AppTextStyles.h2),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              itemCount: dummyAnalysisRecords.length, // TODO: 從後端 API 獲取歷史紀錄
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final record = dummyAnalysisRecords[index];
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.analyzeHistoryBackground,
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
                    onTap: () {
                      // TODO: 連接詳細分析結果 API
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('查看詳細分析結果（功能開發中）')),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
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
}

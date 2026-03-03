import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../config/app_config.dart';
import '../home/providers/tco_history_provider.dart';

class HistoryCenterPage extends ConsumerWidget {
  const HistoryCenterPage({super.key});

  static String _formatTime(DateTime d) {
    return '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')} '
        '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(tcoHistoryProvider);

    return Scaffold(
      backgroundColor: AppColors.neuBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('歷史中心', style: AppTextStyles.h2),
        backgroundColor: AppColors.neuBackground,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: list.isEmpty
            ? Center(
                child: Text(
                  '尚無 TCO 分析紀錄',
                  style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final e = list[i];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: AppConfig.neuStyle(color: AppColors.surface),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                e.brand ?? '未選擇品牌',
                                style: AppTextStyles.bodyBold,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _formatTime(e.computedAt),
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${e.totalBudget.toStringAsFixed(0)} 元',
                          style: AppTextStyles.h5,
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

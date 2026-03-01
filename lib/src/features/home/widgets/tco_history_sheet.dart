import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_config.dart';
import '../../../config/app_text_styles.dart';
import '../providers/tco_history_provider.dart';

void showTcoHistorySheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const _TcoHistorySheet(),
  );
}

class _TcoHistorySheet extends ConsumerWidget {
  const _TcoHistorySheet();

  static String _formatTime(DateTime d) {
    return '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')} '
        '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(tcoHistoryProvider);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: BoxDecoration(
        color: AppColors.neuBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        border: Border.all(color: AppColors.black, width: AppConfig.neuBorderWidth),
        boxShadow: [
          BoxShadow(
            color: AppColors.black,
            offset: const Offset(0, -AppConfig.neuShadowOffset),
            blurRadius: AppConfig.neuShadowBlur,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'TCO 歷史紀錄',
              style: AppTextStyles.h2,
            ),
          ),
          Flexible(
            child: list.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      '尚無紀錄',
                      style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    shrinkWrap: true,
                    itemCount: list.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final e = list[i];
                      return _HistoryBar(entry: e, timeStr: _formatTime(e.computedAt));
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _HistoryBar extends StatelessWidget {
  final TcoHistoryEntry entry;
  final String timeStr;

  const _HistoryBar({required this.entry, required this.timeStr});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
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
                  entry.brand ?? '未選擇品牌',
                  style: AppTextStyles.bodyBold,
                ),
                const SizedBox(height: 4),
                Text(
                  timeStr,
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Text(
            '${entry.totalBudget.toStringAsFixed(0)} 元',
            style: AppTextStyles.h5,
          ),
        ],
      ),
    );
  }
}

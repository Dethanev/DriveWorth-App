import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_config.dart';
import '../../../config/app_text_styles.dart';
import '../../analyze/domain/tco_models.dart';

class TcoExpenseList extends StatelessWidget {
  final TcoResult? result;

  const TcoExpenseList({super.key, this.result});

  static const List<Color> _colors = [
    AppColors.neuCardTax,
    AppColors.neuCardInsurance,
    AppColors.neuCardFuel,
    AppColors.neuCardMaintenance,
    AppColors.neuCardRiskReserve,
  ];

  static const List<String> _labels = ['稅金', '保險', '燃油', '保養', '風險預備金'];

  @override
  Widget build(BuildContext context) {
    if (result == null || result!.total3Year <= 0) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: AppConfig.neuStyle(color: AppColors.surface),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('支出明細', style: AppTextStyles.h4),
            const SizedBox(height: 12),
            Text('完成分析後顯示各項金額', style: AppTextStyles.bodySmall),
          ],
        ),
      );
    }

    final amounts = [
      result!.annualTax,
      result!.annualInsurance,
      result!.annualFuel,
      result!.annualMaintenance,
      result!.annualRiskReserve,
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: AppConfig.neuStyle(color: AppColors.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('支出明細', style: AppTextStyles.h4),
              Icon(Icons.unfold_more, size: 20, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(5, (i) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: AppConfig.neuStyle(color: AppColors.surface),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _colors[i].withValues(alpha: 0.3),
                      border: Border.all(color: AppColors.black, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.receipt_long, color: _colors[i], size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(_labels[i], style: AppTextStyles.bodyBold),
                  ),
                  Text(
                    '${amounts[i].toStringAsFixed(0)} 元',
                    style: AppTextStyles.bodyBold,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

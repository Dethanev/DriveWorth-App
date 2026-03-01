import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_config.dart';
import '../../../config/app_text_styles.dart';
import '../../analyze/domain/tco_models.dart';

class TcoPercentageSection extends StatelessWidget {
  final TcoResult? result;

  const TcoPercentageSection({super.key, this.result});

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
            Text('支出佔比', style: AppTextStyles.h4),
            const SizedBox(height: 12),
            Text('完成分析後顯示百分比', style: AppTextStyles.bodySmall),
          ],
        ),
      );
    }

    final values = [
      result!.annualTax * 3,
      result!.annualInsurance * 3,
      result!.annualFuel * 3,
      result!.annualMaintenance * 3,
      result!.annualRiskReserve * 3,
    ];
    final total = result!.total3Year;
    final percents = values.map((v) => total > 0 ? (v / total * 100) : 0.0).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: AppConfig.neuStyle(color: AppColors.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('支出佔比', style: AppTextStyles.h4),
          const SizedBox(height: 12),
          ...List.generate(5, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: _colors[i],
                      border: Border.all(color: AppColors.black, width: 1),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(_labels[i], style: AppTextStyles.body)),
                  Text('${percents[i].toStringAsFixed(1)}%', style: AppTextStyles.bodyBold),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

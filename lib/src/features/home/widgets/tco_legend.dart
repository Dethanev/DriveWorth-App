import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_styles.dart';
import '../../analyze/domain/tco_models.dart';

class TcoLegend extends StatelessWidget {
  final TcoResult? result;

  const TcoLegend({super.key, this.result});

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
      return Wrap(
        spacing: 16,
        runSpacing: 8,
        children: List.generate(5, (i) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: _colors[i],
                  border: Border.all(color: AppColors.black, width: 1),
                ),
              ),
              const SizedBox(width: 6),
              Text('${_labels[i]} —', style: AppTextStyles.bodySmall),
            ],
          );
        }),
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

    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: List.generate(5, (i) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: _colors[i],
                border: Border.all(color: AppColors.black, width: 1),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '${_labels[i]} ${percents[i].toStringAsFixed(1)}%',
              style: AppTextStyles.bodySmall,
            ),
          ],
        );
      }),
    );
  }
}

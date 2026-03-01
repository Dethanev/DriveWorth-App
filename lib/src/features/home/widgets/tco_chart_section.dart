import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_styles.dart';
import '../../analyze/domain/tco_models.dart';

class TcoChartSection extends StatelessWidget {
  final TcoResult? result;

  const TcoChartSection({super.key, this.result});

  static const List<Color> _segmentColors = [
    AppColors.neuCardTax,
    AppColors.neuCardInsurance,
    AppColors.neuCardFuel,
    AppColors.neuCardMaintenance,
    AppColors.neuCardRiskReserve,
  ];

  @override
  Widget build(BuildContext context) {
    final total = result?.total3Year ?? 0.0;
    if (total <= 0) {
      return SizedBox(
        height: 220,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 56,
                sections: [
                  PieChartSectionData(value: 1, color: AppColors.divider, showTitle: false),
                ],
              ),
              duration: const Duration(milliseconds: 200),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('總預算', style: AppTextStyles.caption),
                const SizedBox(height: 4),
                Text('0 元', style: AppTextStyles.h3),
              ],
            ),
          ],
        ),
      );
    }

    final values = [
      (result!.annualTax * 3),
      (result!.annualInsurance * 3),
      (result!.annualFuel * 3),
      (result!.annualMaintenance * 3),
      (result!.annualRiskReserve * 3),
    ];
    final sections = List.generate(5, (i) {
      return PieChartSectionData(
        value: values[i],
        color: _segmentColors[i],
        showTitle: false,
        radius: 48,
      );
    });

    return SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 56,
              sections: sections,
            ),
            duration: const Duration(milliseconds: 200),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('總預算', style: AppTextStyles.caption),
              const SizedBox(height: 4),
              Text(
                '${total.toStringAsFixed(0)} 元',
                style: AppTextStyles.h3,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

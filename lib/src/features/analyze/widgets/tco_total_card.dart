import 'package:flutter/material.dart';
import '../../../config/app_config.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_styles.dart';
import '../domain/tco_models.dart';

class TcoTotalCard extends StatelessWidget {
  final TcoResult result;

  const TcoTotalCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: AppConfig.neuStyle(color: AppColors.neuCardTotal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TCO 總擁有成本',
            style: AppTextStyles.h2.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 4),
          Text(
            '未來 3 年總預算',
            style: AppTextStyles.caption.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 16),
          Text(
            '${result.total3Year.toStringAsFixed(0)} 元',
            style: AppTextStyles.h1.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 12),
          _row('稅金', result.annualTax),
          _row('保險', result.annualInsurance),
          _row('燃油', result.annualFuel),
          _row('保養', result.annualMaintenance),
        ],
      ),
    );
  }

  Widget _row(String label, double annual) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label（年）',
            style: AppTextStyles.caption.copyWith(color: AppColors.white),
          ),
          Text(
            '${annual.toStringAsFixed(0)} 元',
            style: AppTextStyles.body.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

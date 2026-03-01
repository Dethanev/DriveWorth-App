import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_config.dart';
import '../../../config/app_text_styles.dart';
import '../tco_wizard_page.dart';

class TcoAnalysisButton extends StatelessWidget {
  const TcoAnalysisButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const TcoWizardPage(),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 56),
            alignment: Alignment.center,
            decoration: AppConfig.neuStyle(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '分析',
              style: AppTextStyles.button.copyWith(
                color: AppColors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

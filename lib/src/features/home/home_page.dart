import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import 'providers/tco_result_provider.dart';
import 'widgets/tco_chart_section.dart';
import 'widgets/tco_legend.dart';
import 'widgets/tco_analysis_button.dart';
import 'widgets/tco_percentage_section.dart';
import 'widgets/tco_expense_list.dart';
import 'widgets/tco_history_sheet.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(tcoResultProvider);

    return Scaffold(
      backgroundColor: AppColors.neuBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    style: IconButton.styleFrom(
                      foregroundColor: AppColors.black,
                      minimumSize: const Size(48, 48),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'TCO總擁有成本分析',
                      style: AppTextStyles.h2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.history),
                    onPressed: () => showTcoHistorySheet(context),
                    style: IconButton.styleFrom(
                      foregroundColor: AppColors.black,
                      minimumSize: const Size(48, 48),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TcoChartSection(result: result),
                    const SizedBox(height: 20),
                    TcoLegend(result: result),
                    const SizedBox(height: 24),
                    const TcoAnalysisButton(),
                    const SizedBox(height: 24),
                    TcoPercentageSection(result: result),
                    const SizedBox(height: 16),
                    TcoExpenseList(result: result),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

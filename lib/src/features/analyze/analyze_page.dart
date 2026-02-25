import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import 'domain/tco_calculator.dart';
import 'domain/tco_models.dart';
import 'analyze_history_sheet.dart';
import 'widgets/tax_card.dart';
import 'widgets/insurance_card.dart';
import 'widgets/fuel_card.dart';
import 'widgets/maintenance_card.dart';
import 'widgets/tco_total_card.dart';

class AnalyzePage extends StatefulWidget {
  const AnalyzePage({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<AnalyzePage> createState() => _AnalyzePageState();
}

class _AnalyzePageState extends State<AnalyzePage> {
  late TcoInputs _inputs;
  late TcoResult _result;

  @override
  void initState() {
    super.initState();
    _inputs = const TcoInputs();
    _result = TcoCalculator.compute(_inputs);
  }

  void _updateInputs(TcoInputs Function(TcoInputs) fn) {
    setState(() {
      _inputs = fn(_inputs);
      _result = TcoCalculator.compute(_inputs);
    });
  }

  void _showHistory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AnalyzeHistorySheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBackground,
      appBar: AppBar(
        backgroundColor: AppColors.neuBackground,
        title: Text('TCO 總擁有成本分析', style: AppTextStyles.h1),
        foregroundColor: AppColors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            onPressed: _showHistory,
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  TaxCard(
                    engineCc: _inputs.engineCc,
                    onEngineCcChanged: (v) =>
                        _updateInputs((i) => i.copyWith(engineCc: v)),
                  ),
                  const SizedBox(height: 20),
                  InsuranceCard(
                    plan: _inputs.insurancePlan,
                    manualAmount: _inputs.insuranceManualAmount,
                    onPlanChanged: (v) =>
                        _updateInputs((i) => i.copyWith(insurancePlan: v)),
                    onManualAmountChanged: (v) => _updateInputs(
                        (i) => i.copyWith(insuranceManualAmount: v)),
                  ),
                  const SizedBox(height: 20),
                  FuelCard(
                    yearKm: _inputs.yearKm,
                    kmPerL: _inputs.fuelConsumptionKmPerL,
                    pricePerL: _inputs.fuelPricePerL,
                    onYearKmChanged: (v) =>
                        _updateInputs((i) => i.copyWith(yearKm: v)),
                    onKmPerLChanged: (v) => _updateInputs(
                        (i) => i.copyWith(fuelConsumptionKmPerL: v)),
                    onPricePerLChanged: (v) =>
                        _updateInputs((i) => i.copyWith(fuelPricePerL: v)),
                  ),
                  const SizedBox(height: 20),
                  MaintenanceCard(
                    cost10k: _inputs.maintenance10k,
                    cost40k: _inputs.maintenance40k,
                    cost80k: _inputs.maintenance80k,
                    onCost10kChanged: (v) =>
                        _updateInputs((i) => i.copyWith(maintenance10k: v)),
                    onCost40kChanged: (v) =>
                        _updateInputs((i) => i.copyWith(maintenance40k: v)),
                    onCost80kChanged: (v) =>
                        _updateInputs((i) => i.copyWith(maintenance80k: v)),
                  ),
                  const SizedBox(height: 30),
                  TcoTotalCard(result: _result),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

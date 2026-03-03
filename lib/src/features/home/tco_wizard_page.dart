import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/app_colors.dart';
import '../../config/app_config.dart';
import '../../config/app_text_styles.dart';
import '../analyze/domain/tco_calculator.dart';
import '../analyze/domain/tco_models.dart';
import '../analyze/widgets/tax_card.dart';
import '../analyze/widgets/insurance_card.dart';
import '../analyze/widgets/fuel_card.dart';
import '../analyze/widgets/maintenance_card.dart';
import 'constants/car_brands.dart';
import 'providers/tco_result_provider.dart';
import 'providers/tco_history_provider.dart';

class TcoWizardPage extends ConsumerStatefulWidget {
  const TcoWizardPage({super.key});

  @override
  ConsumerState<TcoWizardPage> createState() => _TcoWizardPageState();
}

class _TcoWizardPageState extends ConsumerState<TcoWizardPage> {
  static const int _totalPages = 5;
  late PageController _pageController;
  late TcoInputs _inputs;
  int _currentPage = 0;
  String? _selectedBrand;
  String? _selectedModel;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _inputs = const TcoInputs();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _updateInputs(TcoInputs Function(TcoInputs) fn) {
    setState(() => _inputs = fn(_inputs));
  }

  void _onNext() {
    if (_currentPage >= _totalPages - 1) {
      final result = TcoCalculator.compute(_inputs);
      ref.read(tcoResultProvider.notifier).setResult(result);
      ref.read(tcoHistoryProvider.notifier).add(TcoHistoryEntry(
            brand: _selectedBrand,
            totalBudget: result.total3Year,
            computedAt: DateTime.now(),
          ));
      Navigator.of(context).pop();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage++);
    }
  }

  void _onBack() {
    if (_currentPage == 0) {
      Navigator.of(context).pop();
    } else {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentPage--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neuBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _BrandModelPage(
                    selectedBrand: _selectedBrand,
                    selectedModel: _selectedModel,
                    onBrandChanged: (v) => setState(() => _selectedBrand = v),
                    onModelChanged: (v) => setState(() => _selectedModel = v),
                  ),
                  _TcoCardPage(
                    child: TaxCard(
                      engineCc: _inputs.engineCc,
                      onEngineCcChanged: (v) =>
                          _updateInputs((i) => i.copyWith(engineCc: v)),
                    ),
                  ),
                  _TcoCardPage(
                    child: InsuranceCard(
                      plan: _inputs.insurancePlan,
                      manualAmount: _inputs.insuranceManualAmount,
                      onPlanChanged: (v) =>
                          _updateInputs((i) => i.copyWith(insurancePlan: v)),
                      onManualAmountChanged: (v) => _updateInputs(
                          (i) => i.copyWith(insuranceManualAmount: v)),
                    ),
                  ),
                  _TcoCardPage(
                    child: FuelCard(
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
                  ),
                  _TcoCardPage(
                    child: MaintenanceCard(
                      cost5k: _inputs.maintenance5k,
                      cost20k: _inputs.maintenance20k,
                      cost60k: _inputs.maintenance60k,
                      onCost5kChanged: (v) =>
                          _updateInputs((i) => i.copyWith(maintenance5k: v)),
                      onCost20kChanged: (v) =>
                          _updateInputs((i) => i.copyWith(maintenance20k: v)),
                      onCost60kChanged: (v) =>
                          _updateInputs((i) => i.copyWith(maintenance60k: v)),
                    ),
                  ),
                ],
              ),
            ),
            _WizardButtons(
              currentPage: _currentPage,
              totalPages: _totalPages,
              onBack: _onBack,
              onNext: _onNext,
            ),
          ],
        ),
      ),
    );
  }
}

class _WizardButtons extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const _WizardButtons({
    required this.currentPage,
    required this.totalPages,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.neuBackground,
        border: Border(
          top: BorderSide(color: AppColors.black, width: AppConfig.neuBorderWidth),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _NeuButton(
              label: '返回',
              color: AppColors.surface,
              textColor: AppColors.black,
              onPressed: onBack,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _NeuButton(
              label: currentPage >= totalPages - 1 ? '完成' : '下一步',
              color: AppColors.accent,
              textColor: AppColors.white,
              onPressed: onNext,
            ),
          ),
        ],
      ),
    );
  }
}

class _NeuButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const _NeuButton({
    required this.label,
    required this.color,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: AppConfig.neuStyle(color: color),
          alignment: Alignment.center,
          child: Text(label, style: AppTextStyles.button.copyWith(color: textColor)),
        ),
      ),
    );
  }
}

class _BrandModelPage extends StatelessWidget {
  final String? selectedBrand;
  final String? selectedModel;
  final ValueChanged<String?> onBrandChanged;
  final ValueChanged<String?> onModelChanged;

  const _BrandModelPage({
    required this.selectedBrand,
    required this.selectedModel,
    required this.onBrandChanged,
    required this.onModelChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '選擇品牌與車款',
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: 24),
            Text('品牌', style: AppTextStyles.bodyBold),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: AppConfig.neuStyle(color: AppColors.surface),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedBrand,
                  hint: const Text('請選擇品牌'),
                  isExpanded: true,
                  items: carBrands
                      .map((b) => DropdownMenuItem<String>(value: b, child: Text(b)))
                      .toList(),
                  onChanged: onBrandChanged,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('車款', style: AppTextStyles.bodyBold),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: AppConfig.neuStyle(color: AppColors.surface),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String?>(
                  value: selectedModel,
                  hint: const Text('請先選擇品牌（車款即將推出）'),
                  isExpanded: true,
                  items: carModelsPlaceholder.isEmpty
                      ? [const DropdownMenuItem<String?>(value: null, child: Text('請先選擇品牌（車款即將推出）'))]
                      : carModelsPlaceholder
                          .map((m) => DropdownMenuItem<String?>(value: m, child: Text(m)))
                          .toList(),
                  onChanged: carModelsPlaceholder.isEmpty ? null : onModelChanged,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TcoCardPage extends StatelessWidget {
  final Widget child;

  const _TcoCardPage({required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: child,
      ),
    );
  }
}

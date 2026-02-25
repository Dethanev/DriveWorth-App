import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/app_config.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_styles.dart';
import '../domain/tco_models.dart';

class InsuranceCard extends StatefulWidget {
  final InsurancePlan plan;
  final double manualAmount;
  final ValueChanged<InsurancePlan> onPlanChanged;
  final ValueChanged<double> onManualAmountChanged;

  const InsuranceCard({
    super.key,
    required this.plan,
    required this.manualAmount,
    required this.onPlanChanged,
    required this.onManualAmountChanged,
  });

  @override
  State<InsuranceCard> createState() => _InsuranceCardState();
}

class _InsuranceCardState extends State<InsuranceCard> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.manualAmount > 0 ? '${widget.manualAmount.toInt()}' : '',
    );
  }

  @override
  void didUpdateWidget(InsuranceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.manualAmount != widget.manualAmount &&
        widget.plan == InsurancePlan.manual) {
      _controller.text = widget.manualAmount > 0
          ? '${widget.manualAmount.toInt()}'
          : '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppConfig.neuStyle(color: AppColors.neuCardInsurance),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '保險',
            style: AppTextStyles.h2,
          ),
          const SizedBox(height: 12),
          SegmentedButton<InsurancePlan>(
            segments: [
              ButtonSegment(
                value: InsurancePlan.manual,
                label: Text('自行輸入',style: AppTextStyles.fontWeight600),
              ),
              ButtonSegment(
                value: InsurancePlan.typeYi,
                label: Text('乙式',style: AppTextStyles.fontWeight600),
              ),
              ButtonSegment(
                value: InsurancePlan.typeBing,
                label: Text('丙式',style: AppTextStyles.fontWeight600),
              ),
            ],
            selected: {widget.plan},
            onSelectionChanged: (s) => widget.onPlanChanged(s.first),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return AppColors.black;
                return AppColors.white;
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return AppColors.white;
                return AppColors.black;
              }),
            ),
          ),
          if (widget.plan == InsurancePlan.manual) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(7),
              ],
              decoration: const InputDecoration(
                hintText: '輸入金額',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (v) {
                final n = double.tryParse(v);
                widget.onManualAmountChanged(n ?? 0);
              },
            ),
          ],
        ],
      ),
    );
  }
}

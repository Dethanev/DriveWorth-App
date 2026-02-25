import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/app_config.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_styles.dart';

class MaintenanceCard extends StatelessWidget {
  final double cost10k;
  final double cost40k;
  final double cost80k;
  final ValueChanged<double> onCost10kChanged;
  final ValueChanged<double> onCost40kChanged;
  final ValueChanged<double> onCost80kChanged;

  const MaintenanceCard({
    super.key,
    required this.cost10k,
    required this.cost40k,
    required this.cost80k,
    required this.onCost10kChanged,
    required this.onCost40kChanged,
    required this.onCost80kChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppConfig.neuStyle(color: AppColors.neuCardMaintenance),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '保養',
            style: AppTextStyles.h2.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 8),
          Text(
            '里程節點預算（1 萬 / 4 萬 / 8 萬 km）',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 12),
          _BudgetRow(label: '1 萬 km', value: cost10k, onChanged: onCost10kChanged),
          const SizedBox(height: 8),
          _BudgetRow(label: '4 萬 km', value: cost40k, onChanged: onCost40kChanged),
          const SizedBox(height: 8),
          _BudgetRow(label: '8 萬 km', value: cost80k, onChanged: onCost80kChanged),
        ],
      ),
    );
  }
}

class _BudgetRow extends StatefulWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  const _BudgetRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<_BudgetRow> createState() => _BudgetRowState();
}

class _BudgetRowState extends State<_BudgetRow> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '${widget.value.toInt()}');
  }

  @override
  void didUpdateWidget(_BudgetRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value &&
        _controller.text != '${widget.value.toInt()}') {
      _controller.text = '${widget.value.toInt()}';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 72,
          child: Text(
            widget.label,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.black),
          ),
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(7),
            ],
            decoration: const InputDecoration(
              suffixText: ' 元',
              border: OutlineInputBorder(),
              isDense: true,
            ),
            onChanged: (v) {
              final n = double.tryParse(v);
              if (n != null && n >= 0) widget.onChanged(n);
            },
          ),
        ),
      ],
    );
  }
}

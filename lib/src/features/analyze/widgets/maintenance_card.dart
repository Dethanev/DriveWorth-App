import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/app_config.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_styles.dart';

class MaintenanceCard extends StatelessWidget {
  final double cost5k;
  final double cost20k;
  final double cost60k;
  final ValueChanged<double> onCost5kChanged;
  final ValueChanged<double> onCost20kChanged;
  final ValueChanged<double> onCost60kChanged;

  const MaintenanceCard({
    super.key,
    required this.cost5k,
    required this.cost20k,
    required this.cost60k,
    required this.onCost5kChanged,
    required this.onCost20kChanged,
    required this.onCost60kChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppConfig.neuStyle(color: AppColors.neuCardMaintenance),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('保養', style: AppTextStyles.h2.copyWith(color: AppColors.black)),
          const SizedBox(height: 12),
          _BudgetRow(label: '5 千 km\n(小保)', value: cost5k, onChanged: onCost5kChanged),
          const SizedBox(height: 8),
          _BudgetRow(label: '2 萬 km\n(中保)', value: cost20k, onChanged: onCost20kChanged),
          const SizedBox(height: 8),
          _BudgetRow(label: '6 萬 km\n(大保)', value: cost60k, onChanged: onCost60kChanged),
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

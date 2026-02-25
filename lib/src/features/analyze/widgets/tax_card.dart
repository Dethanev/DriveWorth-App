import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/app_config.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_styles.dart';
import '../domain/tco_calculator.dart';

class TaxCard extends StatefulWidget {
  final int engineCc;
  final ValueChanged<int> onEngineCcChanged;

  const TaxCard({
    super.key,
    required this.engineCc,
    required this.onEngineCcChanged,
  });

  @override
  State<TaxCard> createState() => _TaxCardState();
}

class _TaxCardState extends State<TaxCard> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '${widget.engineCc}');
  }

  @override
  void didUpdateWidget(TaxCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.engineCc != widget.engineCc &&
        _controller.text != '${widget.engineCc}') {
      _controller.text = '${widget.engineCc}';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final annual = TcoCalculator.annualTaxFromEngineCc(widget.engineCc);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppConfig.neuStyle(color: AppColors.neuCardTax),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('稅金', style: AppTextStyles.h2),
          const SizedBox(height: 8),
          Text(
            '牌照稅 + 燃料費（依排氣量）',
            style: AppTextStyles.bodyBold,
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '排氣量 (c.c.)',
                      style: AppTextStyles.bodySmallBold,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      style: AppTextStyles.bodyBold,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(5),
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      ),
                      onChanged: (v) {
                        final n = int.tryParse(v);
                        if (n != null && n > 0) widget.onEngineCcChanged(n);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '年繳\n${annual.toStringAsFixed(0)} 元',
                style: AppTextStyles.bodyBold,
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

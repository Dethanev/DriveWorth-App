import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/app_config.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_styles.dart';
import '../domain/tco_calculator.dart';
import '../domain/tco_models.dart';

enum FuelGrade { grade92, grade95, grade98 }

extension on FuelGrade {
  String get label => switch (this) {
        FuelGrade.grade92 => '92',
        FuelGrade.grade95 => '95',
        FuelGrade.grade98 => '98',
      };
  double get defaultPricePerL => switch (this) {
        FuelGrade.grade92 => 28,
        FuelGrade.grade95 => 31,
        FuelGrade.grade98 => 34,
      };
}

class FuelCard extends StatelessWidget {
  final double yearKm;
  final double kmPerL;
  final double pricePerL;
  final ValueChanged<double> onYearKmChanged;
  final ValueChanged<double> onKmPerLChanged;
  final ValueChanged<double> onPricePerLChanged;

  const FuelCard({
    super.key,
    required this.yearKm,
    required this.kmPerL,
    required this.pricePerL,
    required this.onYearKmChanged,
    required this.onKmPerLChanged,
    required this.onPricePerLChanged,
  });

  @override
  Widget build(BuildContext context) {
    final inputs = TcoInputs(
      yearKm: yearKm,
      fuelConsumptionKmPerL: kmPerL,
      fuelPricePerL: pricePerL,
    );
    final annual = TcoCalculator.annualFuel(inputs);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: AppConfig.neuStyle(color: AppColors.neuCardFuel),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '燃油',
            style: AppTextStyles.h2.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 10),
          Text(
            '年里程 × 油耗 × 油價',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 20),
          _NumberField(
            label: '年里程 (km)',
            value: yearKm,
            onChanged: onYearKmChanged,
          ),
          const SizedBox(height: 16),
          _NumberField(
            label: '油耗 (km/L)',
            value: kmPerL,
            onChanged: onKmPerLChanged,
          ),
          const SizedBox(height: 16),
          _FuelPriceRow(
            pricePerL: pricePerL,
            onPricePerLChanged: onPricePerLChanged,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '年度油資 ${annual.toStringAsFixed(0)} 元',
              style: AppTextStyles.bodyBold.copyWith(color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberField extends StatefulWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  const _NumberField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<_NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<_NumberField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _format(widget.value));
  }

  @override
  void didUpdateWidget(_NumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value &&
        _controller.text != _format(widget.value)) {
      _controller.text = _format(widget.value);
    }
  }

  String _format(double v) =>
      v == v.roundToDouble() ? '${v.toInt()}' : v.toString();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
            LengthLimitingTextInputFormatter(10),
          ],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          onChanged: (v) {
            final n = double.tryParse(v);
            if (n != null && n >= 0) widget.onChanged(n);
          },
        ),
      ],
    );
  }
}

class _FuelPriceRow extends StatefulWidget {
  final double pricePerL;
  final ValueChanged<double> onPricePerLChanged;

  const _FuelPriceRow({
    required this.pricePerL,
    required this.onPricePerLChanged,
  });

  @override
  State<_FuelPriceRow> createState() => _FuelPriceRowState();
}

class _FuelPriceRowState extends State<_FuelPriceRow> {
  late TextEditingController _priceController;
  FuelGrade? _selectedGrade;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(text: '${widget.pricePerL.toInt()}');
    _selectedGrade = _gradeFromPrice(widget.pricePerL);
  }

  FuelGrade? _gradeFromPrice(double p) {
    for (final g in FuelGrade.values) {
      if (p == g.defaultPricePerL) return g;
    }
    return null;
  }

  @override
  void didUpdateWidget(_FuelPriceRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pricePerL != widget.pricePerL) {
      _priceController.text = widget.pricePerL == widget.pricePerL.roundToDouble()
          ? '${widget.pricePerL.toInt()}'
          : widget.pricePerL.toString();
      _selectedGrade = _gradeFromPrice(widget.pricePerL);
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '油價 (元/L)',
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.black, width: 1.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<FuelGrade>(
                  value: _selectedGrade,
                  hint: Text(
                    '油品',
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                  items: FuelGrade.values
                      .map((g) => DropdownMenuItem(
                            value: g,
                            child: Text('${g.label} 無鉛'),
                          ))
                      .toList(),
                  onChanged: (g) {
                    if (g == null) return;
                    setState(() {
                      _selectedGrade = g;
                      _priceController.text = '${g.defaultPricePerL.toInt()}';
                    });
                    widget.onPricePerLChanged(g.defaultPricePerL);
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                  LengthLimitingTextInputFormatter(6),
                ],
                decoration: const InputDecoration(
                  hintText: '單價',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                onChanged: (v) {
                  final n = double.tryParse(v);
                  if (n != null && n >= 0) {
                    setState(() => _selectedGrade = _gradeFromPrice(n));
                    widget.onPricePerLChanged(n);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Text(
                  '元/L',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.black),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

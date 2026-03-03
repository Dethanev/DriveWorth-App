import 'tco_models.dart';

class TcoCalculator {
  static const int _yearsForTotal = 3;

  static double annualTaxFromEngineCc(int cc) {
    if (cc <= 500) return 3780;
    if (cc <= 600) return 5040;
    if (cc <= 1200) return 8640;
    if (cc <= 1800) return 11920;
    if (cc <= 2400) return 17410;
    if (cc <= 3000) return 22410;
    if (cc <= 3600) return 36860;
    if (cc <= 4200) return 38030;
    if (cc <= 4800) return 57390;
    if (cc <= 5400) return 58350;
    if (cc <= 6000) return 82770;
    if (cc <= 6600) return 83640;
    if (cc <= 7200) return 126610;
    if (cc <= 7800) return 127420;
    return 166920;
  }

  static double annualInsurance(TcoInputs inputs) {
    switch (inputs.insurancePlan) {
      case InsurancePlan.manual:
        return inputs.insuranceManualAmount;
      case InsurancePlan.typeYi:
        return 25000;
      case InsurancePlan.typeBing:
        return 12000;
    }
  }

  static double annualFuel(TcoInputs inputs) {
    if (inputs.fuelConsumptionKmPerL <= 0) return 0;
    final litresPerYear =
        inputs.yearKm / inputs.fuelConsumptionKmPerL;
    return (litresPerYear * inputs.fuelPricePerL * 100).round() / 100;
  }

  static double annualMaintenanceAverage(TcoInputs inputs) {
    const int km5k = 5000, km20k = 20000, km60k = 60000;
    final totalKm = (inputs.yearKm * _yearsForTotal).round();
    final n5k = totalKm ~/ km5k;
    final n20k = totalKm ~/ km20k;
    final n60k = totalKm ~/ km60k;
    final nSmallOnly = n5k - n20k;
    final nMediumOnly = n20k - n60k;
    final total = nSmallOnly * inputs.maintenance5k +
        nMediumOnly * inputs.maintenance20k +
        n60k * inputs.maintenance60k;
    return (total / _yearsForTotal * 100).round() / 100;
  }

  static const double annualRiskReserve = 3000;

  static TcoResult compute(TcoInputs inputs) {
    final tax = annualTaxFromEngineCc(inputs.engineCc);
    final insurance = annualInsurance(inputs);
    final fuel = annualFuel(inputs);
    final maintenance = annualMaintenanceAverage(inputs);
    final annualTotal = tax + insurance + fuel + maintenance + annualRiskReserve;
    final total3Year = (annualTotal * _yearsForTotal * 100).round() / 100;
    return TcoResult(
      annualTax: tax,
      annualInsurance: insurance,
      annualFuel: fuel,
      annualMaintenance: maintenance,
      annualRiskReserve: annualRiskReserve,
      total3Year: total3Year,
    );
  }
}

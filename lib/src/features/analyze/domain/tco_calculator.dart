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
    const double km10k = 10000, km40k = 40000, km80k = 80000;
    final totalKm = inputs.yearKm * _yearsForTotal;
    int n10k = 0, n40k = 0, n80k = 0;
    for (double k = km10k; k <= totalKm; k += km10k) {
      n10k++;
    }
    for (double k = km40k; k <= totalKm; k += km40k) {
      n40k++;
    }
    for (double k = km80k; k <= totalKm; k += km80k) {
      n80k++;
    }
    final total = n10k * inputs.maintenance10k +
        n40k * inputs.maintenance40k +
        n80k * inputs.maintenance80k;
    return (total / _yearsForTotal * 100).round() / 100;
  }

  static TcoResult compute(TcoInputs inputs) {
    final tax = annualTaxFromEngineCc(inputs.engineCc);
    final insurance = annualInsurance(inputs);
    final fuel = annualFuel(inputs);
    final maintenance = annualMaintenanceAverage(inputs);
    final annualTotal = tax + insurance + fuel + maintenance;
    final total3Year = (annualTotal * _yearsForTotal * 100).round() / 100;
    return TcoResult(
      annualTax: tax,
      annualInsurance: insurance,
      annualFuel: fuel,
      annualMaintenance: maintenance,
      total3Year: total3Year,
    );
  }
}

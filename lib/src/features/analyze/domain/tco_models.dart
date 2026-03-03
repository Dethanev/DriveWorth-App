enum InsurancePlan { manual, typeYi, typeBing }

class TcoInputs {
  final int engineCc;
  final InsurancePlan insurancePlan;
  final double insuranceManualAmount;
  final double yearKm;
  final double fuelConsumptionKmPerL;
  final double fuelPricePerL;
  final double maintenance5k;
  final double maintenance20k;
  final double maintenance60k;

  const TcoInputs({
    this.engineCc = 1800,
    this.insurancePlan = InsurancePlan.typeBing,
    this.insuranceManualAmount = 0,
    this.yearKm = 15000,
    this.fuelConsumptionKmPerL = 12,
    this.fuelPricePerL = 32,
    this.maintenance5k = 2500,
    this.maintenance20k = 10000,
    this.maintenance60k = 22000,
  });

  TcoInputs copyWith({
    int? engineCc,
    InsurancePlan? insurancePlan,
    double? insuranceManualAmount,
    double? yearKm,
    double? fuelConsumptionKmPerL,
    double? fuelPricePerL,
    double? maintenance5k,
    double? maintenance20k,
    double? maintenance60k,
  }) {
    return TcoInputs(
      engineCc: engineCc ?? this.engineCc,
      insurancePlan: insurancePlan ?? this.insurancePlan,
      insuranceManualAmount: insuranceManualAmount ?? this.insuranceManualAmount,
      yearKm: yearKm ?? this.yearKm,
      fuelConsumptionKmPerL:
          fuelConsumptionKmPerL ?? this.fuelConsumptionKmPerL,
      fuelPricePerL: fuelPricePerL ?? this.fuelPricePerL,
      maintenance5k: maintenance5k ?? this.maintenance5k,
      maintenance20k: maintenance20k ?? this.maintenance20k,
      maintenance60k: maintenance60k ?? this.maintenance60k,
    );
  }
}

class TcoResult {
  final double annualTax;
  final double annualInsurance;
  final double annualFuel;
  final double annualMaintenance;
  final double annualRiskReserve;
  final double total3Year;

  const TcoResult({
    required this.annualTax,
    required this.annualInsurance,
    required this.annualFuel,
    required this.annualMaintenance,
    required this.annualRiskReserve,
    required this.total3Year,
  });
}

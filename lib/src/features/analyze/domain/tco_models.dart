enum InsurancePlan { manual, typeYi, typeBing }

class TcoInputs {
  final int engineCc;
  final InsurancePlan insurancePlan;
  final double insuranceManualAmount;
  final double yearKm;
  final double fuelConsumptionKmPerL;
  final double fuelPricePerL;
  final double maintenance10k;
  final double maintenance40k;
  final double maintenance80k;

  const TcoInputs({
    this.engineCc = 1800,
    this.insurancePlan = InsurancePlan.typeBing,
    this.insuranceManualAmount = 0,
    this.yearKm = 15000,
    this.fuelConsumptionKmPerL = 12,
    this.fuelPricePerL = 32,
    this.maintenance10k = 4000,
    this.maintenance40k = 12000,
    this.maintenance80k = 18000,
  });

  TcoInputs copyWith({
    int? engineCc,
    InsurancePlan? insurancePlan,
    double? insuranceManualAmount,
    double? yearKm,
    double? fuelConsumptionKmPerL,
    double? fuelPricePerL,
    double? maintenance10k,
    double? maintenance40k,
    double? maintenance80k,
  }) {
    return TcoInputs(
      engineCc: engineCc ?? this.engineCc,
      insurancePlan: insurancePlan ?? this.insurancePlan,
      insuranceManualAmount: insuranceManualAmount ?? this.insuranceManualAmount,
      yearKm: yearKm ?? this.yearKm,
      fuelConsumptionKmPerL:
          fuelConsumptionKmPerL ?? this.fuelConsumptionKmPerL,
      fuelPricePerL: fuelPricePerL ?? this.fuelPricePerL,
      maintenance10k: maintenance10k ?? this.maintenance10k,
      maintenance40k: maintenance40k ?? this.maintenance40k,
      maintenance80k: maintenance80k ?? this.maintenance80k,
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

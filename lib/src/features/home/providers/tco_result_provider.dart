import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../analyze/domain/tco_calculator.dart';
import '../../analyze/domain/tco_models.dart';

final tcoResultProvider = StateNotifierProvider<TcoResultNotifier, TcoResult?>(
  (ref) => TcoResultNotifier(),
);

class TcoResultNotifier extends StateNotifier<TcoResult?> {
  TcoResultNotifier() : super(null);

  void setResult(TcoResult result) {
    state = result;
  }

  void setFromInputs(TcoInputs inputs) {
    state = TcoCalculator.compute(inputs);
  }

  void clear() {
    state = null;
  }
}

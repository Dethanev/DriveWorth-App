import 'package:flutter_riverpod/flutter_riverpod.dart';

class TcoHistoryEntry {
  final String? brand;
  final double totalBudget;
  final DateTime computedAt;

  const TcoHistoryEntry({
    this.brand,
    required this.totalBudget,
    required this.computedAt,
  });
}

final tcoHistoryProvider =
    StateNotifierProvider<TcoHistoryNotifier, List<TcoHistoryEntry>>(
  (ref) => TcoHistoryNotifier(),
);

class TcoHistoryNotifier extends StateNotifier<List<TcoHistoryEntry>> {
  TcoHistoryNotifier() : super([]);

  void add(TcoHistoryEntry entry) {
    state = [entry, ...state];
  }
}

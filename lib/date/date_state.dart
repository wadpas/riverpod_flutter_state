import 'package:hooks_riverpod/hooks_riverpod.dart';

final class Date extends StateNotifier<DateTime> {
  Date() : super(DateTime.now());
  void increment() => state = DateTime(state.year, state.month, state.day + 1);
  void decrement() => state = DateTime(state.year, state.month, state.day - 1);
  void reset() => state = DateTime.now();
}

final dateProvider = StateNotifierProvider<Date, DateTime>(
  (ref) => Date(),
);

final currentDate = Provider<DateTime>(
  (ref) => DateTime.now(),
);

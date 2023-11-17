import 'package:hooks_riverpod/hooks_riverpod.dart';

final class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  void increment() => state = (state ?? 0) + 1;
}

final counterProvider = StateNotifierProvider<Counter, int?>(
  (ref) => Counter(),
);

// extension InfixAddition<T extends num> on T? {
//   T? operator +(T? other) {
//     final shadow = this;
//     if (shadow != null) {
//       return shadow + (other ?? 0) as T;
//     } else {
//       return null;
//     }
//   }
// }
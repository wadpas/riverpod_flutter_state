import 'package:hooks_riverpod/hooks_riverpod.dart';

enum Country { Germany, France, Italy, Spain, Belgium }

final class Counter extends StateNotifier<int?> {
  Counter() : super(0);
  void increment() {
    if (state! < Country.values.length) {
      state = (state ?? 0) + 1;
    }
  }
}

Future<String> getCapital(Country country) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => {
      Country.Germany: 'Berlin',
      Country.France: 'Paris',
      Country.Italy: 'Rome',
      Country.Spain: 'Madrid',
      Country.Belgium: 'Brussels'
    }[country]!,
  );
}

final countryProvider = StateProvider<Country?>((ref) => null);

final capitalProvider = FutureProvider<String>(
  (ref) {
    final country = ref.watch(countryProvider);
    if (country != null) {
      return getCapital(country);
    } else {
      return 'Check country';
    }
  },
);

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


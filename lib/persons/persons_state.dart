import 'package:hooks_riverpod/hooks_riverpod.dart';

const names = ['Alice', 'Lary', 'Mariam', 'Marina', 'Irene'];

final tickerProvider = StreamProvider(
  (ref) => Stream.periodic(
    const Duration(seconds: 1),
    (i) => i + 1,
  ),
);

final namesProvider = StreamProvider(
  (ref) {
    return ref.watch(tickerProvider.stream).map(
      (count) {
        return names.getRange(0, count);
      },
    );
  },
);

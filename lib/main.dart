import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(currentDate);
    final currentWeather = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod'),
      ),
      body: Center(
        child: Column(
          children: [
            currentWeather.when(
              data: (data) => Text(data),
              error: (_, __) => const Text("Error 😒"),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: City.values.length,
                itemBuilder: (context, index) {
                  final city = City.values[index];
                  final isSelected = city == ref.watch(cityProvider);
                  return ListTile(
                    title: Text(
                      city.toString(),
                    ),
                    trailing: isSelected ? const Icon(Icons.check) : null,
                    onTap: () {
                      ref.read(cityProvider.notifier).state = city;
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: ref.read(counterProvider.notifier).increment,
              child: const Text('Counter'),
            ),
            Consumer(
              builder: (context, ref, child) {
                final count = ref.watch(counterProvider);
                final text =
                    count == null ? 'Press the button' : count.toString();
                return Text(text);
              },
            ),
            Text(
              date.toIso8601String(),
            ),
          ],
        ),
      ),
    );
  }
}

enum City { stockholm, paris, tokyo }

typedef WeatherEmoji = String;

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => {
      City.stockholm: '❄️',
      City.paris: '🌧️',
      City.tokyo: '💨',
    }[city]!,
  );
}

final cityProvider = StateProvider<City?>((ref) => null);

final weatherProvider = FutureProvider<WeatherEmoji>(
  (ref) {
    final city = ref.watch(cityProvider);
    if (city != null) {
      return getWeather(city);
    } else {
      return '🤷‍♀️';
    }
  },
);

final class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  void increment() => state = state == null ? 1 : state + 1;
}

final counterProvider = StateNotifierProvider<Counter, int?>(
  (ref) => Counter(),
);

extension InfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

final currentDate = Provider<DateTime>(
  (ref) => DateTime.now(),
);

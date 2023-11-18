import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_flutter_state/weather/weather_state.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Column(
        children: [
          currentWeather.when(
            data: (data) => Text(
              data,
              style: const TextStyle(fontSize: 30),
            ),
            error: (error, stackTrace) => const Text('Error 😒'),
            loading: () => const CircularProgressIndicator(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: City.values.length,
              itemBuilder: (context, index) {
                final city = City.values[index];
                final isSelected = city == ref.watch(cityProvider);
                return ListTile(
                  title: Text(city.toString()),
                  trailing: isSelected ? const Icon(Icons.check) : null,
                  onTap: () {
                    ref.read(cityProvider.notifier).state = city;
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

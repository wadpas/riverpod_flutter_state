import 'package:hooks_riverpod/hooks_riverpod.dart';

enum City { Stockholm, Paris, Tokyo }

typedef WeatherEmoji = String;

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => {
      City.Stockholm: '❄️',
      City.Paris: '🌧️',
      City.Tokyo: '💨',
    }[city]!,
  );
}

final cityProvider = StateProvider<City?>((ref) => null);

const unknownEmoji = '🤷‍♀️';

final weatherProvider = FutureProvider<WeatherEmoji>(
  (ref) {
    final city = ref.watch(cityProvider);
    if (city != null) {
      return getWeather(city);
    } else {
      return unknownEmoji;
    }
  },
);

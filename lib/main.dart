import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_flutter_state/counter/counter_page.dart';
import 'package:riverpod_flutter_state/date/date_page.dart';
import 'package:riverpod_flutter_state/films/films_page.dart';
import 'package:riverpod_flutter_state/persons/persons_page.dart';
import 'package:riverpod_flutter_state/weather/weather_page.dart';

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
      routes: {
        '/date_page': (context) => const DatePage(),
        '/counter_page': (context) => const CounterPage(),
        '/weather_page': (context) => const WeatherPage(),
        '/names_page': (context) => const PersonsPage(),
        '/films_page': (context) => const FilmsPage(),
      },
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/films_page');
              },
              child: const Text('Films'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/names_page');
              },
              child: const Text('Names'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/date_page');
              },
              child: const Text('Date'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/counter_page');
              },
              child: const Text('Counter'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/weather_page');
              },
              child: const Text('Weather'),
            ),
          ],
        ),
      ),
    );
  }
}

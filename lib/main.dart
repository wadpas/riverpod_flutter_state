import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_flutter_state/counter/counter_page.dart';
import 'package:riverpod_flutter_state/date/date_page.dart';
import 'package:riverpod_flutter_state/weather/weather_page.dart';
import 'package:uuid/uuid.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          Consumer(
            builder: (context, ref, child) {
              final dataModel = ref.watch(peopleProvider);
              return ListView.builder(
                shrinkWrap: true,
                itemCount: dataModel.count,
                itemBuilder: (context, index) {
                  final person = dataModel.people[index];
                  return ListTile(
                    title: GestureDetector(
                      child: Text(person.displayName),
                      onTap: () async {
                        final updatedPerson =
                            await createOrUpdatePersonDialog(context, person);
                        if (updatedPerson != null) {
                          dataModel.update(updatedPerson);
                        }
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final person = await createOrUpdatePersonDialog(context);
          if (person != null) {
            final dataModel = ref.read(peopleProvider);
            dataModel.add(person);
          }
        },
      ),
    );
  }
}

final nameController = TextEditingController();
final ageController = TextEditingController();

Future<Person?> createOrUpdatePersonDialog(
  BuildContext context, [
  Person? existingPerson,
]) {
  String? name = existingPerson?.name;
  int? age = existingPerson?.age;

  nameController.text = name ?? '';
  ageController.text = age?.toString() ?? '';

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Create a person'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Enter name here...',
              ),
              onChanged: (value) => name = value,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: 'Enter age here...',
              ),
              onChanged: (value) => age = int.tryParse(value),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (name != null && age != null) {
                if (existingPerson != null) {
                  final newPerson = existingPerson.updated(name, age);
                  Navigator.of(context).pop(newPerson);
                } else {
                  Navigator.of(context).pop(
                    Person(name: name!, age: age!),
                  );
                }
              } else {
                () => Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          )
        ],
      );
    },
  );
}

@immutable
class Person {
  final String name;
  final int age;
  final String uuid;

  Person({
    required this.name,
    required this.age,
    String? uuid,
  }) : uuid = uuid ?? const Uuid().v4();

  Person updated([String? name, int? age]) => Person(
        name: name ?? this.name,
        age: age ?? this.age,
        uuid: uuid,
      );
  String get displayName => '$name ($age years old)';

  @override
  bool operator ==(covariant Person other) => uuid == other.uuid;

  @override
  int get hashCode => Object.hash(name, age, uuid);
}

class DataModel extends ChangeNotifier {
  final List<Person> _people = [];
  int get count => _people.length;

  UnmodifiableListView<Person> get people => UnmodifiableListView(_people);

  void add(Person person) {
    _people.add(person);
    notifyListeners();
  }

  void remove(Person person) {
    _people.remove(person);
    notifyListeners();
  }

  void update(Person updatedPerson) {
    final index = _people.indexOf(updatedPerson);
    final oldPerson = _people[index];
    if (oldPerson.name != updatedPerson.name ||
        oldPerson.age != updatedPerson.age) {
      _people[index] = oldPerson.updated(
        updatedPerson.name,
        updatedPerson.age,
      );
      notifyListeners();
    }
  }
}

final peopleProvider = ChangeNotifierProvider(
  (_) => DataModel(),
);

const names = ['Mary', 'Marie', 'Mariam', 'Marina', 'Irene'];

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

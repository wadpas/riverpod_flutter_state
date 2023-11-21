import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_flutter_state/counter/counter_state.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    final capital = ref.watch(capitalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            capital.when(
              data: (data) => Text(
                data,
                style: const TextStyle(fontSize: 22),
              ),
              error: (error, stackTrace) => const Text('Error (('),
              loading: () => const CircularProgressIndicator(),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: count,
              itemBuilder: (context, index) {
                final country = Country.values[index];
                final isSelected = country == ref.watch(countryProvider);
                return ListTile(
                  title: Text(country.toString().split('.').last),
                  trailing: isSelected ? const Icon(Icons.check) : null,
                  onTap: () =>
                      ref.read(countryProvider.notifier).state = country,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: ref.read(counterProvider.notifier).increment,
                  child: const Text('More ->'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(count.toString()),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

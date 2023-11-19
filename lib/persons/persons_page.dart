import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_flutter_state/persons/persons_state.dart';

class PersonsPage extends ConsumerWidget {
  const PersonsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons'),
      ),
      body: Center(
        child: Column(
          children: [
            names.when(
              data: (names) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: names.length,
                      itemBuilder: (context, index) {
                        final name = names.elementAt(index);
                        return ListTile(
                          title: Text(name),
                        );
                      }),
                );
              },
              error: (error, stackTrace) =>
                  const Text('Reach the end of the list'),
              loading: () => const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

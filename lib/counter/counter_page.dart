import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_flutter_state/counter/counter_state.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final count = ref.watch(counterProvider);
                final text =
                    count == null ? 'Press the button' : count.toString();
                return Text(text);
              },
            ),
            ElevatedButton(
              onPressed: ref.read(counterProvider.notifier).increment,
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

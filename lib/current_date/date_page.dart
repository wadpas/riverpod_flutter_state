import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_flutter_state/current_date/date_state.dart';

class DatePage extends ConsumerWidget {
  const DatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer(
            builder: (context, ref, child) => Text(
              ref.watch(dateProvider).toIso8601String().substring(0, 10),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: ref.read(dateProvider.notifier).increment,
                child: const Text('Increment'),
              ),
              ElevatedButton(
                onPressed: ref.read(dateProvider.notifier).decrement,
                child: const Text('Decrement'),
              ),
            ],
          ),
          TextButton(
            onPressed: ref.read(dateProvider.notifier).reset,
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

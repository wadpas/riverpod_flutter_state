import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_flutter_state/current_date/provider.dart';

class CurrentDate extends ConsumerWidget {
  const CurrentDate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(currentDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Date'),
      ),
      body: Center(
        child: Text(
          date.toIso8601String(),
        ),
      ),
    );
  }
}

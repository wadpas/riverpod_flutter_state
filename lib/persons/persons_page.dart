import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_flutter_state/persons/persons_state.dart';

class PersonsPage extends ConsumerWidget {
  const PersonsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons'),
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

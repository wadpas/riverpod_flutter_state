import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_flutter_state/films/films_filter.dart';
import 'package:riverpod_flutter_state/films/films_list.dart';
import 'package:riverpod_flutter_state/films/films_state.dart';

class FilmsPage extends ConsumerWidget {
  const FilmsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Films'),
      ),
      body: Column(
        children: [
          const FilmsFilter(),
          Consumer(
            builder: (context, ref, child) {
              final filter = ref.watch(favoriteStatusProvider);
              switch (filter) {
                case FavoriteStatus.All:
                  return FilmsList(allFilmsProvider);
                case FavoriteStatus.Favorite:
                  return FilmsList(favoriteFilmsProvider);
                case FavoriteStatus.Usual:
                  return FilmsList(usualFilmsProvider);
              }
            },
          )
        ],
      ),
    );
  }
}

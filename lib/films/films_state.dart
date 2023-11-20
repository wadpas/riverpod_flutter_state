import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_flutter_state/films/film_model.dart';

const allFilms = [
  Film(
    id: '1',
    name: 'Playtime',
    description: 'Monsieur Hulot curiously wanders around a high-tech Paris',
    isFavorite: false,
  ),
  Film(
    id: '2',
    name: 'Some Like It Hot',
    description: 'When two male musicians witness a mob hit',
    isFavorite: false,
  ),
  Film(
    id: '3',
    name: 'Ratatouille',
    description: 'Despite his sensational sniffer and sophisticated palate',
    isFavorite: false,
  ),
  Film(
    id: '4',
    name: 'The Apartment',
    description:
        'A man tries to rise in his company by letting its executives use his apartment',
    isFavorite: false,
  ),
];

final class FilmsNotifier extends StateNotifier<List<Film>> {
  FilmsNotifier() : super(allFilms);

  void update(Film updatedFilm, bool isFavorite) {
    state = state
        .map((film) => film.id == updatedFilm.id
            ? film.copy(isFavorite: isFavorite)
            : film)
        .toList();
  }
}

enum FavoriteStatus { all, favorite, usual }

final favoriteStatusProvider = StateProvider<FavoriteStatus>(
  (_) => FavoriteStatus.all,
);

final allFilmsProvider = StateNotifierProvider<FilmsNotifier, List<Film>>(
  (_) => FilmsNotifier(),
);

final favoriteFilmsProvider = Provider<Iterable<Film>>(
  (ref) => ref.watch(allFilmsProvider).where(
        (film) => film.isFavorite,
      ),
);

final usualFilmsProvider = Provider<Iterable<Film>>(
  (ref) => ref.watch(allFilmsProvider).where(
        (film) => !film.isFavorite,
      ),
);

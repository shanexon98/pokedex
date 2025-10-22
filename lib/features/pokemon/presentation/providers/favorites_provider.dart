import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<Set<int>> {
  FavoritesNotifier() : super(<int>{});

  bool isFavorite(int id) => state.contains(id);

  void toggle(int id) {
    if (state.contains(id)) {
      final next = Set<int>.from(state)..remove(id);
      state = next;
    } else {
      final next = Set<int>.from(state)..add(id);
      state = next;
    }
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<int>>(
  (ref) => FavoritesNotifier(),
);
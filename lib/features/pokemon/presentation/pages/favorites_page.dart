import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/features/pokemon/presentation/providers/favorites_provider.dart';
import 'package:pokemon/features/pokemon/presentation/providers/pokemon_providers.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/pokemon_card.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/skeleton_card.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/error_card.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final ids = favorites.toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: ids.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Opacity(
                      opacity: 0.6,
                      child: Image(
                        image: AssetImage('assets/images/noresults.png'),
                        width: 220,
                        height: 220,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No has marcado ningún Pokémon como favorito',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Haz clic en el ícono de corazón de tus Pokémon favoritos y aparecerán aquí.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.4),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: ids.length,
              itemBuilder: (context, index) {
                final id = ids[index];
                final detailAsync = ref.watch(pokemonDetailByIdProvider(id));

                return Dismissible(
                  key: ValueKey('fav_$id'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.red.shade400,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    ref.read(favoritesProvider.notifier).toggle(id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Eliminado de favoritos: #$id')),
                    );
                  },
                  child: detailAsync.when(
                    data: (detail) => PokemonCard(
                      id: detail.id,
                      name: detail.name,
                      spriteUrl: detail.spriteUrl,
                      types: detail.types,
                    ),
                    loading: () => const SkeletonCard(),
                    error: (e, st) => ErrorCard(message: 'No se pudo cargar el favorito #$id'),
                  ),
                );
              },
            ),
    );
  }
}
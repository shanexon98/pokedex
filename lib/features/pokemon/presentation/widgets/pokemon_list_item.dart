import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/features/pokemon/presentation/providers/pokemon_providers.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/pokemon_card.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/skeleton_card.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/error_card.dart';

class PokemonListItem extends ConsumerWidget {
  const PokemonListItem({super.key, required this.name, required this.url});

  final String name;
  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(pokemonDetailProvider(url));
    final selectedTypes = ref.watch(selectedTypesProvider);

    return detailAsync.when(
      loading: () => const SkeletonCard(),
      error: (err, stack) => ErrorCard(message: err.toString()),
      data: (detail) {
        if (selectedTypes.isNotEmpty &&
            !detail.types.any((t) => selectedTypes.contains(t))) {
          return const SizedBox.shrink();
        }
        return PokemonCard(
          id: detail.id,
          name: detail.name,
          spriteUrl: detail.spriteUrl,
          types: detail.types,
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/features/pokemon/presentation/providers/pokemon_providers.dart';

class FilterResultCounter extends ConsumerWidget {
  const FilterResultCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedTypesProvider);
    if (selected.isEmpty) return const SizedBox.shrink();

    final asyncPokemons = ref.watch(filteredPokemonListProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: asyncPokemons.when(
        data: (list) {
          final matchedCount = list.where((p) {
            final detailAsync = ref.watch(pokemonDetailProvider(p.url));
            return detailAsync.maybeWhen(
              data: (detail) => detail.types.any((t) => selected.contains(t)),
              orElse: () => false,
            );
          }).length;

          return Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                    children: [
                      const TextSpan(text: 'Se han encontrado '),
                      TextSpan(
                        text: '$matchedCount resultados',
                        style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () => ref.read(selectedTypesProvider.notifier).clear(),
                child: const Text('Borrar filtro'),
              ),
            ],
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (e, st) => const SizedBox.shrink(),
      ),
    );
  }
}
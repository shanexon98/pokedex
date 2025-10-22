import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon/features/pokemon/presentation/providers/pokemon_providers.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/pokemon_list_item.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/pokemon_filter_header.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/filter_result_counter.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/error_state.dart';
import 'package:pokemon/features/pokemon/presentation/widgets/pokeball_loader.dart';

class PokemonListPage extends ConsumerWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPokemons = ref.watch(filteredPokemonListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const PokemonFilterHeader(),
          const FilterResultCounter(),
          Expanded(
            child: asyncPokemons.when(
              data: (list) => ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final p = list[index];
                  return PokemonListItem(name: p.name, url: p.url);
                },
              ),
              loading: () => const Center(child: PokeballLoader(size: 72, amplitude: 18, opacity: 0.9)),
              error: (e, st) => ErrorState(
                title: 'Algo salió mal...',
                description:
                    'No pudimos cargar la información en este momento.\nVerifica tu conexión o intenta nuevamente más tarde.',
                assetPath: 'assets/images/noresults.png',
                onRetry: () {
                  ref.invalidate(filteredPokemonListProvider);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

}
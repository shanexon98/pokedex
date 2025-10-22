import 'package:pokemon/core/dio_client.dart';
import 'package:pokemon/features/pokemon/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokemon/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokemon/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon/features/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokemon/features/pokemon/domain/entities/pokemon_species.dart';
import 'package:pokemon/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokemon/features/pokemon/domain/usecases/get_pokemon_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'pokemon_providers.g.dart';

@riverpod
DioClient dioClient(DioClientRef ref) => DioClient();

@riverpod
PokemonRemoteDataSource pokemonRemoteDataSource(PokemonRemoteDataSourceRef ref) =>
    PokemonRemoteDataSource(ref.watch(dioClientProvider));

@riverpod
PokemonRepository pokemonRepository(PokemonRepositoryRef ref) =>
    PokemonRepositoryImpl(ref.watch(pokemonRemoteDataSourceProvider));

@riverpod
GetPokemonList getPokemonList(GetPokemonListRef ref) =>
    GetPokemonList(ref.watch(pokemonRepositoryProvider));

@riverpod
Future<List<Pokemon>> pokemonList(PokemonListRef ref, {int limit = 20, int offset = 0}) async {
  final usecase = ref.watch(getPokemonListProvider);
  return usecase(limit: limit, offset: offset);
}

// Detail provider using family (no codegen required)
final pokemonDetailProvider = FutureProvider.family<PokemonDetail, String>((ref, url) async {
  final repo = ref.watch(pokemonRepositoryProvider);
  return repo.fetchPokemonDetailByUrl(url);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredPokemonListProvider = Provider<AsyncValue<List<Pokemon>>>((ref) {
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final asyncList = ref.watch(pokemonListProvider(limit: 200));
  return asyncList.whenData((list) {
    if (query.isEmpty) return list;
    return list
        .where((p) => p.name.toLowerCase().contains(query))
        .toList(growable: false);
  });
});

final pokemonDetailByIdProvider = FutureProvider.family<PokemonDetail, int>((ref, id) async {
  final repo = ref.watch(pokemonRepositoryProvider);

  final url = 'https://pokeapi.co/api/v2/pokemon/$id';
  return repo.fetchPokemonDetailByUrl(url);
});

final pokemonSpeciesByIdProvider = FutureProvider.family<PokemonSpecies, int>((ref, id) async {
  final repo = ref.watch(pokemonRepositoryProvider);
  return repo.fetchPokemonSpeciesById(id);
});

class SelectedTypesNotifier extends StateNotifier<Set<String>> {
  SelectedTypesNotifier() : super(<String>{});
  void toggle(String type) {
    if (state.contains(type)) {
      state = Set<String>.from(state)..remove(type);
    } else {
      state = Set<String>.from(state)..add(type);
    }
  }
  void clear() => state = <String>{};
}

final selectedTypesProvider =
    StateNotifierProvider<SelectedTypesNotifier, Set<String>>((ref) => SelectedTypesNotifier());
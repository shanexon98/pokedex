import 'package:pokemon/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonList {
  const GetPokemonList(this._repo);
  final PokemonRepository _repo;

  Future<List<Pokemon>> call({int limit = 20, int offset = 0}) {
    return _repo.fetchPokemonList(limit: limit, offset: offset);
  }
}
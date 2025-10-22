import 'package:pokemon/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon/features/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokemon/features/pokemon/domain/entities/pokemon_species.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> fetchPokemonList({int limit = 20, int offset = 0});
  Future<PokemonDetail> fetchPokemonDetailByUrl(String url);
  Future<PokemonSpecies> fetchPokemonSpeciesById(int id);
}
import 'package:pokemon/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon/features/pokemon/domain/entities/pokemon_detail.dart';
import 'package:pokemon/features/pokemon/domain/entities/pokemon_species.dart';
import 'package:pokemon/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokemon/features/pokemon/data/datasources/pokemon_remote_datasource.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl(this._remote);
  final PokemonRemoteDataSource _remote;

  @override
  Future<List<Pokemon>> fetchPokemonList({int limit = 20, int offset = 0}) async {
    final list = await _remote.getPokemonList(limit: limit, offset: offset);
    return list.map(Pokemon.fromJson).toList(growable: false);
  }

  @override
  Future<PokemonDetail> fetchPokemonDetailByUrl(String url) async {
    final json = await _remote.getPokemonDetailByUrl(url);
    return PokemonDetail.fromJson(json);
  }

  @override
  Future<PokemonSpecies> fetchPokemonSpeciesById(int id) async {
    final json = await _remote.getPokemonSpeciesById(id);
    return PokemonSpecies.fromJson(json);
  }
}
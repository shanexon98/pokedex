import 'package:dio/dio.dart';
import 'package:pokemon/core/dio_client.dart';
import 'package:pokemon/features/pokemon/domain/entities/pokemon.dart';
  
class PokemonRepository {
  PokemonRepository(this._client);

  final DioClient _client;

  Future<List<Pokemon>> fetchPokemonList({int limit = 20, int offset = 0}) async {
    try {
      final Response<dynamic> res = await _client.dio.get(
        '/pokemon',
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );
      final data = res.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;
      return results
          .map((e) => Pokemon.fromJson(e as Map<String, dynamic>))
          .toList(growable: false);
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
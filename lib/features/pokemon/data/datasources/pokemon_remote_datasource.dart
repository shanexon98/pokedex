import 'package:dio/dio.dart';
import 'package:pokemon/core/dio_client.dart';

class PokemonRemoteDataSource {
  PokemonRemoteDataSource(this._client);
  final DioClient _client;

  Future<List<Map<String, dynamic>>> getPokemonList({int limit = 20, int offset = 0}) async {
    final Response<dynamic> res = await _client.dio.get(
      '/pokemon',
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );
    final data = res.data as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>;
    return results.cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> getPokemonDetailByUrl(String url) async {
    final Response<dynamic> res = await _client.dio.getUri(Uri.parse(url));
    return res.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getPokemonSpeciesById(int id) async {
    final Response<dynamic> res = await _client.dio.get('/pokemon-species/$id');
    return res.data as Map<String, dynamic>;
  }
}
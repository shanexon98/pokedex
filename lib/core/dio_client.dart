import 'package:dio/dio.dart';

class DioClient {
  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://pokeapi.co/api/v2',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );

  final Dio dio;
}
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/repository/api_routes.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    log('DioClient constructor called');

    dio = Dio(
      BaseOptions(
        baseUrl: ApiRoutes().baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('REQUEST: ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('RESPONSE: ${response.statusCode}');
          log('DATA: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log('DIO ERROR: ${e.message}');
          log('ERROR TYPE: ${e.type}');
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get({required String endpoint, Map<String, dynamic>? queryParameters}) async {
    log('GET METHOD CALLED');

    try {
      final response = await dio.get(endpoint, queryParameters: queryParameters);

      return response;
    } on DioException catch (e) {
      log('GET API FAILED: ${e.message}');
      rethrow;
    }
  }
}

import 'package:delviery_smartcare/core/servieces/faliure_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'token_storage_service.dart';

class ApiService {
  final Dio dio;
  final TokenStorageService? storage;

  VoidCallback? onUnauthorized;
  Function(String)? onTokenRefreshed;

  ApiService(this.dio, {this.storage}) {
    dio.options = BaseOptions(
      baseUrl: 'https://smartcarepharmacy.tryasp.net/',
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
    );

    // ✅ Interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage?.getAccessToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            onUnauthorized?.call();
          }
          return handler.next(error);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, error: true),
      );
    }
  }

  // =========================
  // GET
  // =========================
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? query}) async {
    try {
      final response = await dio.get(endpoint, queryParameters: query);
      return response.data;
    } on DioException catch (e) {
      throw ServiveFailure.fromDioError(e);
    }
  }

  // =========================
  // POST
  // =========================
  Future<dynamic> post(String endpoint, dynamic body) async {
    try {
      final response = await dio.post(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ServiveFailure.fromDioError(e);
    }
  }

  // =========================
  // PUT
  // =========================
  Future<dynamic> put(String endpoint, dynamic body) async {
    try {
      final response = await dio.put(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ServiveFailure.fromDioError(e);
    }
  }

  // =========================
  // DELETE
  // =========================
  Future<dynamic> delete(String endpoint, dynamic body) async {
    try {
      final response = await dio.delete(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ServiveFailure.fromDioError(e);
    }
  }

  // =========================
  // PATCH
  // =========================
  Future<dynamic> patch(String endpoint, dynamic body) async {
    try {
      final response = await dio.patch(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ServiveFailure.fromDioError(e);
    }
  }
}

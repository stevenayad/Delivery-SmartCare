import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../errors/failure.dart';
import 'token_storage_service.dart';
import 'token_interceptor.dart';

class ApiService {
  static const String baseUrl = 'https://smartcarepharmacy.tryasp.net/api';
  late Dio _dio;
  final TokenStorageService? _tokenStorage;

  ApiService({TokenStorageService? tokenStorage})
    : _tokenStorage = tokenStorage {
    _initializeDio();
  }

  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: Headers.jsonContentType,
        validateStatus: (status) => true,
      ),
    );

    // Add token interceptor if token storage is provided
    if (_tokenStorage != null) {
      _dio.interceptors.add(TokenInterceptor(tokenStorage: _tokenStorage!));
    }

    // Add logging interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('[API REQUEST] ${options.method} ${options.path}');
          debugPrint('[API BODY] ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('[API RESPONSE] ${response.statusCode} ${response}');
          debugPrint('[API DATA] ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          debugPrint('[API ERROR] ${error.message}');
          debugPrint('[API ERROR RESPONSE] ${error.response?.data}');
          return handler.next(error);
        },
      ),
    );
  }

  Future<Either<Failure, Response<T>>> post<T>(
    String endpoint, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post<T>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );
      return Right(response);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.message}');
      return Left(_handleDioError(e));
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return Left(UnknownFailure('An unexpected error occurred: $e'));
    }
  }

  Future<Either<Failure, Response<T>>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        endpoint,
        queryParameters: queryParameters,
      );
      return Right(response);
    } on DioException catch (e) {
      debugPrint('DioException: ${e.message}');
      return Left(_handleDioError(e));
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return Left(UnknownFailure('An unexpected error occurred: $e'));
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkFailure('Connection timeout. Please check your internet');
      case DioExceptionType.sendTimeout:
        return NetworkFailure('Send timeout. Please check your internet');
      case DioExceptionType.receiveTimeout:
        return NetworkFailure('Server took too long to respond');
      case DioExceptionType.connectionError:
        return NetworkFailure('Network error. Please check your connection');
      case DioExceptionType.unknown:
        return NetworkFailure('Unknown network error: ${error.message}');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        return ServerFailure(
          statusCode: statusCode,
          message: error.response?.data['message'] ?? 'Server error',
        );
      case DioExceptionType.cancel:
        return NetworkFailure('Request cancelled');
      case DioExceptionType.badCertificate:
        return NetworkFailure('Bad certificate. Security error');
    }
  }
}

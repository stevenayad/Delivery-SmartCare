import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../errors/failure.dart';
import 'token_storage_service.dart';

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
  }

  // =========================
  // 🔥 GET
  // =========================
  Future<Either<Failure, Response>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final token = await _tokenStorage?.getAccessToken();
      final headers = <String, dynamic>{};
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      print("🔥 TOKEN => $token");

      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      debugPrint('[API REQUEST] GET $endpoint');
      debugPrint('[HEADERS] ${response.requestOptions.headers}');
      debugPrint('[API RESPONSE] ${response.statusCode}');
      debugPrint('[API DATA] ${response.data}');

      if (response.statusCode != null && response.statusCode! >= 400) {
        return Left(
          ServerFailure(
            statusCode: response.statusCode!,
            message: response.data?.toString() ?? 'Server error',
          ),
        );
      }

      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure('Unexpected error: $e'));
    }
  }

  // =========================
  // 🔥 POST
  // =========================
  Future<Either<Failure, Response>> post(
    String endpoint, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final token = await _tokenStorage?.getAccessToken();
      final headers = <String, dynamic>{};
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }

      print("🔥 TOKEN => $token");

      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      debugPrint('[API REQUEST] POST $endpoint');
      debugPrint('[HEADERS] ${response.requestOptions.headers}');
      debugPrint('[API RESPONSE] ${response.statusCode}');
      debugPrint('[API DATA] ${response.data}');

      if (response.statusCode != null && response.statusCode! >= 400) {
        return Left(
          ServerFailure(
            statusCode: response.statusCode!,
            message: response.data?.toString() ?? 'Server error',
          ),
        );
      }

      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(UnknownFailure('Unexpected error: $e'));
    }
  }

  // =========================
  // 🔥 ERROR HANDLER
  // =========================
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkFailure('Connection timeout');
      case DioExceptionType.sendTimeout:
        return NetworkFailure('Send timeout');
      case DioExceptionType.receiveTimeout:
        return NetworkFailure('Receive timeout');
      case DioExceptionType.connectionError:
        return NetworkFailure('No internet connection');
      case DioExceptionType.badResponse:
        return ServerFailure(
          statusCode: error.response?.statusCode ?? 0,
          message: error.response?.data?.toString() ?? 'Server error',
        );
      default:
        return UnknownFailure(error.message ?? 'Unknown error');
    }
  }
}

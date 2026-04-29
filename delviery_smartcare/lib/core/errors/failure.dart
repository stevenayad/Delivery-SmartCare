import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  final int statusCode;
  ServerFailure({required this.statusCode, required String message})
    : super(message);
}


class FailureHandler {
  
  static Failure handleResponse({
    required int? statusCode,
    String? message,
  }) {
    switch (statusCode) {
      case 400:
        return ServerFailure(
          statusCode: 400,
          message: message ?? 'Bad request. Please check your inputs',
        );

      case 401:
        return ServerFailure(
          statusCode: 401,
          message: message ?? 'Invalid email or password',
        );

      case 403:
        return ServerFailure(
          statusCode: 403,
          message: message ?? 'Forbidden request',
        );

      case 404:
        return ServerFailure(
          statusCode: 404,
          message: message ?? 'Resource not found',
        );

      case 500:
        return ServerFailure(
          statusCode: 500,
          message: message ?? 'Internal server error',
        );

      default:
        return ServerFailure(
          statusCode: statusCode ?? 0,
          message: message ?? 'Unexpected server error',
        );
    }
  }

  static Failure handleException(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return NetworkFailure('Connection timeout');
      }

      if (error.type == DioExceptionType.badResponse) {
        return handleResponse(
          statusCode: error.response?.statusCode,
          message: error.response?.data?['message'],
        );
      }

      return NetworkFailure('Network error occurred');
    }

    return UnknownFailure('Unexpected error: $error');
  }
}

class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}

class ParseFailure extends Failure {
  ParseFailure(String message) : super(message);
}

class UnknownFailure extends Failure {
  UnknownFailure(String message) : super(message);
}

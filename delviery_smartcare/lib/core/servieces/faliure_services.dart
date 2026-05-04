import 'dart:convert';
import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

class ServiveFailure extends Failure {
  ServiveFailure(String errMessage) : super(errMessage);

  factory ServiveFailure.fromDioError(DioException dioerror) {
    switch (dioerror.type) {
      case DioExceptionType.connectionTimeout:
        return ServiveFailure("Connection timeout With ApiServer");
      case DioExceptionType.sendTimeout:
        return ServiveFailure("Send timeout With ApiServer");
      case DioExceptionType.receiveTimeout:
        return ServiveFailure("Receive timeout With ApiServer");
      case DioExceptionType.badResponse:
        return ServiveFailure.badResponse(
          dioerror.response?.statusCode ?? 0,
          dioerror.response?.data,
        );
      case DioExceptionType.cancel:
        return ServiveFailure("Request cancelled");
      case DioExceptionType.connectionError:
        return ServiveFailure("No internet connection");
      case DioExceptionType.unknown:
        return ServiveFailure("Unexpected error");
      default:
        return ServiveFailure("Oops error");
    }
  }

  factory ServiveFailure.badResponse(int statusCode, dynamic response) {
    String message = "Unknown error";

    if (response is String) {
      try {
        response = jsonDecode(response);
      } catch (_) {}
    }

    if (response is Map<String, dynamic>) {
      if (response.containsKey('message')) {
        message = response['message'];
      }
    }

    if (statusCode == 404) {
      message = "Not found";
    } else if (statusCode == 500) {
      message = "Server error";
    }

    return ServiveFailure(message);
  }
}

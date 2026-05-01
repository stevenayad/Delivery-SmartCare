import 'dart:convert';
import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

class servivefailure extends Failure {
  servivefailure(String errMessage) : super(errMessage);

  factory servivefailure.fromDioError(DioException dioerror) {
    switch (dioerror.type) {
      case DioExceptionType.connectionTimeout:
        return servivefailure("Connection timeout With ApiServer");
      case DioExceptionType.sendTimeout:
        return servivefailure("Send timeout With ApiServer");
      case DioExceptionType.receiveTimeout:
        return servivefailure("Receive timeout With ApiServer");
      case DioExceptionType.badResponse:
        return servivefailure.badResponse(
          dioerror.response?.statusCode ?? 0,
          dioerror.response?.data,
        );
      case DioExceptionType.cancel:
        return servivefailure("Request cancelled");
      case DioExceptionType.connectionError:
        return servivefailure("No internet connection");
      case DioExceptionType.unknown:
        return servivefailure("Unexpected error");
      default:
        return servivefailure("Oops error");
    }
  }

  factory servivefailure.badResponse(int statusCode, dynamic response) {
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

    return servivefailure(message);
  }
}
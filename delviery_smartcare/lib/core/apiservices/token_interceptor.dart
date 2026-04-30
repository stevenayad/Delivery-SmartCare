import 'package:dio/dio.dart';
import 'token_storage_service.dart';

class TokenInterceptor extends Interceptor {
  final TokenStorageService _tokenStorage;

  TokenInterceptor({required TokenStorageService tokenStorage})
    : _tokenStorage = tokenStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStorage.getAccessToken();
    print('token => ${token}');
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    return handler.next(err);
  }

  
}

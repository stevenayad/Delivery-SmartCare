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

    print('================ REQUEST ================');
    print('URL => ${options.baseUrl}${options.path}');
    print('METHOD => ${options.method}');
    print('TOKEN => $token');
    print('HEADERS BEFORE => ${options.headers}');
    print('DATA => ${options.data}');
    print('QUERY => ${options.queryParameters}');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    print('HEADERS AFTER => ${options.headers}');
    print('=========================================');

    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    print('================ RESPONSE ===============');
    print('URL => ${response.requestOptions.uri}');
    print('STATUS CODE => ${response.statusCode}');
    print('DATA => ${response.data}');
    print('=========================================');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('================ ERROR ==================');
    print('URL => ${err.requestOptions.uri}');
    print('STATUS CODE => ${err.response?.statusCode}');
    print('MESSAGE => ${err.message}');
    print('RESPONSE => ${err.response?.data}');
    print('=========================================');

    handler.next(err);
  }
}

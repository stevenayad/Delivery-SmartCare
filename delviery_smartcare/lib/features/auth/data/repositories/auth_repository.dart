import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/apiservices/api_service.dart';
import '../../../../core/apiservices/token_storage_service.dart';
import '../models/api_response_model.dart';
import '../models/auth_tokens_model.dart';
import '../models/login_request_model.dart';

class AuthRepository {
  final ApiService _apiService;
  final TokenStorageService _tokenStorage;

  AuthRepository({
    required ApiService apiService,
    required TokenStorageService tokenStorage,
  }) : _apiService = apiService,
       _tokenStorage = tokenStorage;

  Future<Either<Failure, AuthTokens>> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequest(email: email, password: password);

      final result = await _apiService.post<Map<String, dynamic>>(
        '/auth/login',
        data: request.toJson(),
      );

      return result.fold((failure) => Left(failure), (response) {
        try {
          final apiResponse = ApiResponse<AuthTokens>.fromJson(
            response.data!,
            (json) => AuthTokens.fromJson(json),
          );

          if (apiResponse.succeeded && apiResponse.data != null) {
            final tokens = apiResponse.data!;
            _tokenStorage.saveTokens(
              accessToken: tokens.accessToken,
              refreshToken: tokens.refreshToken,
            );
            return Right(tokens);
          } else {
            return Left(
              FailureHandler.handleResponse(
                statusCode: response.statusCode,
                message: apiResponse.message,
              ),
            );
          }
        } catch (e) {
          return Left(ParseFailure('Failed to parse response: $e'));
        }
      });
    } catch (e) {
      return Left(FailureHandler.handleException(e));
    }
  }

  Future<void> logout() async {
    await _tokenStorage.clearTokens();
  }

  Future<String?> getAccessToken() async {
    return await _tokenStorage.getAccessToken();
  }

  Future<bool> isAuthenticated() async {
    final token = await _tokenStorage.getAccessToken();
    return token != null && token.isNotEmpty;
  }
}

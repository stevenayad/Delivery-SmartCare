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

      final result = await _apiService.post(
        '/auth/login',
        data: request.toJson(),
      );

      return result.fold((failure) => Left<Failure, AuthTokens>(failure), (
        response,
      ) async {
        try {
          final apiResponse = ApiResponse<AuthTokens>.fromJson(
            response.data,
            (json) => AuthTokens.fromJson(json),
          );

          if (apiResponse.succeeded && apiResponse.data != null) {
            final tokens = apiResponse.data!;

            await _tokenStorage.saveTokens(
              accessToken: tokens.accessToken,
              refreshToken: tokens.refreshToken,
            );
            final savedToken = await _tokenStorage.getAccessToken();
            print("✅ SAVED TOKEN => $savedToken");

            return Right<Failure, AuthTokens>(tokens);
          } else {
            return Left<Failure, AuthTokens>(
              FailureHandler.handleResponse(
                statusCode: response.statusCode,
                message: apiResponse.message,
              ),
            );
          }
        } catch (e) {
          return Left<Failure, AuthTokens>(ParseFailure('Parse error: $e'));
        }
      });
    } catch (e) {
      return Left<Failure, AuthTokens>(FailureHandler.handleException(e));
    }
  }
}

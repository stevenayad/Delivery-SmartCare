import 'package:dartz/dartz.dart';
import 'package:delviery_smartcare/core/servieces/faliure_services.dart';
import '../../../../core/errors/failure.dart' hide Failure;
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
  })  : _apiService = apiService,
        _tokenStorage = tokenStorage;

  Future<Either<Failure, AuthTokens>> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequest(email: email, password: password);

      final response = await _apiService.post(
        '/api/auth/login',
        request.toJson(),
      );

      final apiResponse = ApiResponse<AuthTokens>.fromJson(
        response,
        (json) => AuthTokens.fromJson(json),
      );

      if (apiResponse.succeeded && apiResponse.data != null) {
        final tokens = apiResponse.data!;

        await _tokenStorage.saveTokens(
          accessToken: tokens.accessToken,
          refreshToken: tokens.refreshToken,
        );

        return Right(tokens);
      } else {
        return Left(servivefailure(apiResponse.message));
      }
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(servivefailure("Unexpected error"));
    }
  }
}
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/apiservices/api_service.dart';
import '../../core/apiservices/token_storage_service.dart';
import 'data/repositories/auth_repository.dart';
import 'presentation/cubits/auth_cubit.dart';

class AuthSetup {
  static AuthCubit createAuthCubit() {
    const secureStorage = FlutterSecureStorage();
    final tokenStorage = TokenStorageService(secureStorage);
    final apiService = ApiService(tokenStorage: tokenStorage);
    final authRepository = AuthRepository(
      apiService: apiService,
      tokenStorage: tokenStorage,
    );
    return AuthCubit(authRepository: authRepository);
  }
}

import 'package:meta/meta.dart';
import '../../data/models/auth_tokens_model.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final AuthTokens tokens;
  AuthSuccess(this.tokens);
}

final class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

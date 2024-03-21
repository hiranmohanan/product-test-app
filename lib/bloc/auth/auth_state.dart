part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoginLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthLoginFailure extends AuthState {
  final String error;

  AuthLoginFailure(this.error);
}

class AuthRegisterLoading extends AuthState {}

class AuthRegisterSuccess extends AuthState {}

class AuthRegisterFailure extends AuthState {
  final String error;

  AuthRegisterFailure(this.error);
}

class AuthPinLoginLoading extends AuthState {}

class AuthPinLoginSuccess extends AuthState {}

class AuthPinLoginFailure extends AuthState {
  final String error;

  AuthPinLoginFailure(this.error);
}

class AuthLogoutSuccess extends AuthState {}

class AuthLogoutFailure extends AuthState {
  final String error;

  AuthLogoutFailure(this.error);
}

class AuthLogoutLoading extends AuthState {}

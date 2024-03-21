part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLoginStarted extends AuthEvent {
  final String email;
  final String password;
  final int pin;

  AuthLoginStarted(this.email, this.password, this.pin);
}

class AuthRegisterStarted extends AuthEvent {
  final String email;
  final String password;
  final int pin;

  AuthRegisterStarted(this.email, this.password, this.pin);
}

class AuthPinLoginStarted extends AuthEvent {
  final int pin;

  AuthPinLoginStarted(this.pin);
}

class AuthLogout extends AuthEvent {}

part of 'splash_bloc.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashSuccess extends SplashState {
  final bool logedin;

  SplashSuccess({this.logedin = false});
}

class SplashFailure extends SplashState {
  final String error;

  SplashFailure(this.error);
}

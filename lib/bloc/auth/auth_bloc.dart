import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/hive/hive.dart';
import 'package:product_app/services/local_auth_services.dart';

import '../../firebase/fire_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthRegisterStarted>(_signupWithEmailAndPassword);
    on<AuthPinLoginStarted>(_loginwithpin);
    on<AuthLoginStarted>(_loginwithemail);
    on<AuthLogout>(_signOut);
    on<AuthBioMatricLoginStarted>(_biomatricLogin);
  }

  Future<void> _signupWithEmailAndPassword(
    AuthRegisterStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthRegisterLoading());
    final responce = await FireBaseAuthProvider()
        .signupwithemailandpassword(event.email, event.password);
    if (responce == null) {
      hivebox.put('pin', event.pin);
      if (kDebugMode) {
        print(
            'Pin: ${event.pin}============================= ${hivebox.get('pin')}');
      }
      emit(AuthRegisterSuccess());
    } else {
      emit(AuthRegisterFailure(responce.toString()));
    }
  }

  Future<void> _loginwithpin(
      AuthPinLoginStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoading());
    try {
      final pin = await hivebox.get('pin');
      if (kDebugMode) {
        print('Pin: $pin');
        print('Event Pin: ${event.pin}');
      }
      if (pin == event.pin) {
        emit(AuthPinLoginSuccess());
      } else {
        emit(AuthPinLoginFailure('Invalid Pin'));
      }
    } catch (e) {
      emit(AuthPinLoginFailure('Error :- $e'));
    }
  }

  Future<void> _signOut(AuthLogout event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLogoutLoading());
      final responce = await FireBaseAuthProvider().signOut();
      if (responce is String) {
        emit(AuthLogoutFailure(responce));
      } else {
        hivebox.delete('pin');

        emit(AuthLogoutSuccess());
      }
    } catch (e) {
      emit(AuthLogoutFailure(e.toString()));
    }
  }

  Future<void> _loginwithemail(
      AuthLoginStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoading());
    final responce = await FireBaseAuthProvider()
        .signInWithEmailAndPassword(event.email, event.password);
    if (responce is String) {
      emit(AuthLoginFailure(responce));
    } else {
      hivebox.put('pin', event.pin);
      if (kDebugMode) {
        print(
            'Pin: ${event.pin}============================= ${hivebox.get('pin')}');
      }
      emit(AuthLoginSuccess());
    }
  }

  Future<void> _biomatricLogin(
      AuthBioMatricLoginStarted event, Emitter<AuthState> emit) async {
    emit(AuthBioMatricLoginLoading());
    try {
      final responce = await BioMatrics().authenticateBio();
      if (responce) {
        emit(AuthBioMatricLoginSuccess());
      } else {
        emit(AuthBioMatricLoginFailure('Biometric Authentication Failed'));
      }
    } catch (e) {
      emit(AuthBioMatricLoginFailure(e.toString()));
    }
  }
}

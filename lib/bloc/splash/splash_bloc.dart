import 'package:flutter_bloc/flutter_bloc.dart';

import '../../firebase/fire_auth.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>(_init);
  }

  Future<void> _init(SplashStarted event, Emitter<SplashState> emit) async {
    emit(SplashLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      final responce = await FireBaseAuthProvider().checkcurrentuser();

      if (responce == null) {
        emit(SplashSuccess(logedin: false));
      } else {
        emit(SplashSuccess(logedin: true));
      }
    } catch (e) {
      emit(SplashFailure(e.toString()));
    }
  }

  Future checkuser() async {
    final responce = await FireBaseAuthProvider().checkcurrentuser();
    return responce;
  }
}

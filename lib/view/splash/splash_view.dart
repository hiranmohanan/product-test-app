import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/constants/constants.dart';

import '../../bloc/splash/splash_bloc.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add(SplashStarted());
    return Scaffold(
      body: Center(
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashLoading) {
              return;
            }

            if (state is SplashFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
            if (state is SplashSuccess) {
              state.logedin == true
                  ? Navigator.pushReplacementNamed(context, '/pin')
                  : Navigator.pushReplacementNamed(context, '/login');
            }
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              LinearProgressIndicator(
                color: Colors.black26,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              SizedBox(height: 20),
              Text(KStrings.loading),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

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
                  duration: const Duration(milliseconds: 5000),
                ),
              );
            }
            if (state is SplashSuccess) {
              state.logedin == true
                  ? Navigator.pushReplacementNamed(context, '/pin')
                  : Navigator.pushReplacementNamed(context, '/login');
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              Text(
                KStrings.appName,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: const LinearProgressIndicator(
                  color: Colors.black26,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              const Text(KStrings.loading),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

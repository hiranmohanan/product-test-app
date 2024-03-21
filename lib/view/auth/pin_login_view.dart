import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/constants/constants.dart';

import '../../bloc/auth/auth_bloc.dart';

class PinLoginView extends StatefulWidget {
  const PinLoginView({Key? key});

  @override
  State<PinLoginView> createState() => _PinLoginViewState();
}

class _PinLoginViewState extends State<PinLoginView> {
  TextEditingController pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthPinLoginFailure) {
          showAdaptiveDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.error),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'))
                  ],
                );
              });
        }
        if (state is AuthPinLoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthLoginLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              const Text('Enter your PIN'),
              const SizedBox(height: 20),
              TextFormField(
                controller: pinController,
                obscureText: true,
                maxLength: 4,
                keyboardType: TextInputType.number,
                decoration: inutDecoration(
                  label: KStrings.pin,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<AuthBloc>()
                      .add(AuthPinLoginStarted(int.parse(pinController.text)));
                },
                child: const Text('Login'),
              ),
              const Spacer()
            ],
          ),
        );
      },
    ));
  }

  InputDecoration inutDecoration({required String label}) {
    return InputDecoration(
      counterText: '',
      border: const OutlineInputBorder(),
      labelText: label,
    );
  }
}

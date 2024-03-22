import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/widgets/widgets.dart';

import '../../bloc/auth/auth_bloc.dart';

class PinLoginView extends StatefulWidget {
  const PinLoginView({Key? key});

  @override
  State<PinLoginView> createState() => _PinLoginViewState();
}

class _PinLoginViewState extends State<PinLoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Initialize TextEditingControllers
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());

  // Initialize FocusNodes
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

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
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: 50,
                        child: TextFormField(
                          controller: controllers[index],
                          focusNode: focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          obscureText: true,
                          decoration: const InputDecoration(counterText: ''),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value.length == 1 && index < 3) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index + 1]);
                            } else if (value.isEmpty && index != 0) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index - 1]);
                              // Optionally, clear the previous field
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final pin = controllers.fold<String>(
                        '',
                        (previousValue, element) =>
                            previousValue + element.text);
                    context
                        .read<AuthBloc>()
                        .add(AuthPinLoginStarted(int.parse(pin)));
                  }
                  showsnackbar(
                      error: 'Please Enter Valid Pin', context: context);
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
}

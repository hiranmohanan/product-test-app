import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/bloc/auth/auth_bloc.dart';
import 'package:product_app/constants/constants.dart';
import 'package:product_app/view/auth/auth_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(KStrings.login),
          centerTitle: true,
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoginFailure) {
              showDialog(
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
                          child: const Text('OK'),
                        )
                      ],
                    );
                  });
            }
            if (state is AuthLoginSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            }
          },
          builder: (context, state) {
            if (state is AuthLoginLoading) {
              return loading();
            }
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(KStrings.enterYourEmail),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: KStrings.email,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(KStrings.enterYourPassword),
                        const SizedBox(height: 10),
                        PasswordField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return KStrings.enterYourPassword;
                            }
                            return null;
                          },
                          controller: passwordController,
                          label: KStrings.password,
                        ),
                        const SizedBox(height: 10),
                        const Text(KStrings.enterYourPin),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: pinController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your pin';
                            }
                            if (value.length < 4) {
                              return 'Pin must be at least 4 characters';
                            }
                            return null;
                          },
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          decoration: inutDecoration(label: KStrings.pin),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(AuthLoginStarted(
                                    emailController.text,
                                    passwordController.text,
                                    int.parse(pinController.text)));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter valid data'),
                                  ),
                                );
                              }
                            },
                            child: const Text(KStrings.login),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: RichText(
                              text: TextSpan(
                            text: KStrings.dontHaveAnAccount,
                            style: const TextStyle(color: Colors.black),
                            children: [
                              WidgetSpan(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                                child: const Text(KStrings.signup,
                                    style: TextStyle(color: Colors.blue)),
                              ))
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
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

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

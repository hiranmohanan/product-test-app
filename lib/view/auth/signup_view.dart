import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/bloc/auth/auth_bloc.dart';
import 'package:product_app/constants/constants.dart';

import '../../widgets/widgets.dart';
import 'auth_widget.dart';

class SingupView extends StatefulWidget {
  const SingupView({super.key});

  @override
  State<SingupView> createState() => _SingupViewState();
}

class _SingupViewState extends State<SingupView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      emailController = TextEditingController();
      passwordController = TextEditingController();
      confirmPasswordController = TextEditingController();
      pinController = TextEditingController();
    }

    @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
      pinController.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(KStrings.signup),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisterFailure) {
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
          if (state is AuthRegisterSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthRegisterLoading) {
            return loading();
          }
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(KStrings.enterYourEmail),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }

                          if (!value.contains('.')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: KStrings.email,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(KStrings.enterYourPassword),
                      const SizedBox(height: 10),
                      PasswordField(
                        controller: passwordController,
                        label: KStrings.password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          } else if (!value.contains(RegExp(r'[A-Z]'))) {
                            return 'Password must contain at least one uppercase letter';
                          } else if (!value.contains(RegExp(r'[0-9]'))) {
                            return 'Password must contain at least one number';
                          } else if (!value
                              .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return 'Password must contain at least one special character';
                          } else if (value.contains(' ')) {
                            return 'Password must not contain any spaces';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(KStrings.confirmPassword),
                      const SizedBox(height: 10),
                      PasswordField(
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return KStrings.enterYourPassword;
                          }
                          if (value != passwordController.text) {
                            return KStrings.pleaseenteravalidpassword;
                          }
                          return null;
                        },
                        label: KStrings.confirmPassword,
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
                              context.read<AuthBloc>().add(AuthRegisterStarted(
                                  emailController.text,
                                  passwordController.text,
                                  int.parse(
                                    pinController.text,
                                  )));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter valid data'),
                                ),
                              );
                            }
                          },
                          child: const Text(KStrings.register),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: RichText(
                            text: TextSpan(
                          text: KStrings.alreadyHaveAnAccount,
                          style: const TextStyle(color: Colors.black),
                          children: [
                            WidgetSpan(
                                child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/login', (route) => false);
                              },
                              child: const Text(KStrings.login,
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
      ),
    );
  }
}

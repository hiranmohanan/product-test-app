import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';

void looutbuttonfn(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLogoutSuccess) {
              // Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            }
          },
          builder: (context, state) {
            return AlertDialog(
              title: const Text('Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogout());
                  },
                  child: const Text('Logout'),
                )
              ],
            );
          },
        );
      });
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

showsnackbar({required String error, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(error)),
  );
}

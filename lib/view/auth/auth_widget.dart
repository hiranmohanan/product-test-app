import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {super.key,
      required this.controller,
      required this.label,
      required this.validator});

  final TextEditingController controller;
  final String label;
  final FormFieldValidator validator;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isvisible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isvisible,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.label,
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isvisible = !isvisible;
                });
              },
              icon: Icon(isvisible == true
                  ? Icons.visibility_off
                  : Icons.visibility))),
    );
  }
}

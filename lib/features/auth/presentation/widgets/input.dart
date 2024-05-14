import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String hint;
  final bool isObscure;
  final TextEditingController? controller;

  const Input({
    super.key,
    required this.hint,
    this.controller,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hint field cannot be empty';
        }

        return null;
      },
    );
  }
}

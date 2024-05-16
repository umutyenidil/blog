import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final bool isExpandable;
  final TextEditingController controller;
  final String? hint;

  const Input({
    super.key,
    required this.controller,
    this.hint,
    this.isExpandable = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      maxLines: isExpandable ? null : 1,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hint field cannot be empty';
        }

        return null;
      },
    );
  }
}

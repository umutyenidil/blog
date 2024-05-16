import 'package:blog/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class TopicChip extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isActive;
  final String label;

  const TopicChip({
    super.key,
    this.onPressed,
    this.isActive = false,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Chip(
        color: WidgetStatePropertyAll(
          isActive ? AppPallete.gradient1 : AppPallete.backgroundColor,
        ),
        label: Text(label),
        side: const BorderSide(
          color: AppPallete.borderColor,
        ),
      ),
    );
  }
}

import 'package:blog/core/constants/border_radius.constants.dart';
import 'package:blog/core/constants/color.constants.dart';
import 'package:blog/core/constants/edge_insets.constants.dart';
import 'package:blog/core/constants/text_style.constants.dart';
import 'package:blog/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class LinearGradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const LinearGradientButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusConstants.ALL12,
        ),
        gradient: LinearGradient(
          colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
            AppPallete.gradient3,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 0),
          surfaceTintColor: ColorConstants.TRANSPARENT,
          shadowColor: ColorConstants.TRANSPARENT,
          padding: EdgeInsetsConstants.ALL24,
          backgroundColor: ColorConstants.TRANSPARENT,
          splashFactory: InkRipple.splashFactory,
          foregroundColor: ColorConstants.WHITE,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusConstants.ALL12,
          ),
        ),
        child: Text(
          label,
          style: TextStyleConstants.REGULAR16,
        ),
      ),
    );
  }
}

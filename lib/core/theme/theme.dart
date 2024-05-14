import 'package:blog/core/constants/border_radius.constants.dart';
import 'package:blog/core/constants/double.constants.dart';
import 'package:blog/core/constants/edge_insets.constants.dart';
import 'package:blog/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderRadius: BorderRadiusConstants.ALL12,
        borderSide: BorderSide(
          color: color,
          width: DoubleConstants.X2,
        ),
      );
  static final darkMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsetsConstants.ALL24,
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
    ),
  );
}

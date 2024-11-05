import 'package:flutter/material.dart';
import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/extensions/to_double_extension.dart';
import 'package:moment/features/app/constants/constants.dart';
import 'package:moment/features/app/theme/colors/app_colors.dart';

class AppTheme {
  static final light = ThemeData(
    primaryColor: appColorsLight.primaryColor,
    colorScheme: ColorScheme(
      primary: appColorsLight.primaryColor,
      secondary: appColorsLight.secondaryColor,
      surface: appColorsLight.surfaceColor,
      error: errorColor,
      onPrimary: const Color(0xFFFFFFFF),
      onSecondary: const Color(0xFF000000),
      onSurface: const Color(0xFF212121),
      onError: const Color(0xFFFFFFFF),
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: DDimension.bigPadding.radius,
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: DDimension.bigPadding.radius,
          borderSide: BorderSide(
            color: appColorsLight.grey,
            width: 1.5,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: DDimension.bigPadding.radius,
          borderSide: BorderSide(color: appColorsLight.primaryRed)),
      focusedBorder: OutlineInputBorder(
        borderRadius: DDimension.bigPadding.radius,
        borderSide: BorderSide(
          width: 1.5,
          color: appColorsLight.primaryColor,
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      selectedItemColor: appColorsLight.primaryColor,
      unselectedItemColor: Colors.grey,
    ),
  );
}

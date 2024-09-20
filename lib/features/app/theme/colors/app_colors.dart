import 'package:flutter/material.dart';
import 'package:moment/features/app/theme/colors/app_colors_light.dart';

final appColorsLight = AppColorsLight();

abstract class AppColors {
  Color get primaryYellow;
  Color get primaryGreen;
  Color get primaryBlue;
  Color get primaryRed;

  Color get scaffoldBackground;

  Color get grey;
  Color get gray80;
  Color get gray60;
  Color get gray40;
  Color get gray20;
  Color get gray10;
  Color get gradationGrey;

  Color get white;
  Color get black;
  Color get black40;
  Color get secondaryGreen;

  Color get tertiaryRed;
  Color get tertiaryGreen;

  static AppColors of(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return appColorsLight;
      default:
        return appColorsLight;
    }
  }
}

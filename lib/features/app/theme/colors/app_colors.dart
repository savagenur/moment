import 'package:flutter/material.dart';
import 'package:moment/features/app/theme/colors/app_colors_light.dart';

final appColorsLight = AppColorsLight();

// Define essential colors with variations
abstract class AppColors {
  // Primary colors
  Color get primaryYellow;
  Color get primaryGreen;
  Color get primaryBlue;
  Color get primaryRed;
  
  // Basic color palette
  Color get primaryColor;
  Color get primaryLight;
  Color get primaryDark;
  Color get secondaryColor;
  Color get secondaryLight;
  Color get secondaryDark;
  Color get surfaceColor;
  Color get surfaceLight;
  Color get surfaceDark;
  Color get scaffoldBackground;

  // Grayscale palette
  Color get grey;
  Color get gray80;
  Color get gray60;
  Color get gray40;
  Color get gray20;
  Color get gray10;

  // Additional colors
  Color get white;
  Color get black;
  Color get black40;

  // Static method to select colors based on brightness (light mode for now)
  static AppColors of(BuildContext context) {
    return appColorsLight; // Only light mode implemented
  }
}

import 'package:flutter/material.dart';
import 'package:moment/features/app/theme/colors/app_colors.dart';

class AppTheme {
  static final light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: appColorsLight.primaryGreen),
    useMaterial3: true,
    
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      selectedItemColor: appColorsLight.primaryGreen,
      unselectedItemColor: Colors.grey,
    ),
  );


}
import 'package:flutter/material.dart';
import 'package:moment/features/app/theme/colors/app_colors.dart';

class AppColorsLight implements AppColors {
  @override
  Color get black => Colors.black;
  @override
  Color get white => Colors.white;

  @override
  Color get black40 => Colors.black38;
  @override
  Color get scaffoldBackground => Colors.white;

  @override
  Color get grey => Colors.grey;

  @override
  Color get gray10 => Colors.grey.shade900;

  @override
  Color get gray20 => const Color(0xFF4C6D86);

  @override
  Color get gradationGrey => const Color(0xFF4C6D86);

  @override
  Color get gray40 => const Color(0xFFC7D7E4);

  @override
  Color get gray60 => const Color(0xFFE0E9F3);

  @override
  Color get gray80 => const Color(0xFFF2F6F9);

  @override
  Color get primaryBlue => const Color(0xFF326BD8);

  @override
  Color get primaryGreen => const Color(0xFF126B60);

  @override
  Color get primaryRed => const Color(0xFFFF001F);

  @override
  Color get primaryYellow => const Color(0xFFFFC531);

  @override
  Color get secondaryGreen => const Color(0xFF40B0A3);

  @override
  Color get tertiaryGreen => const Color(0xFF);

  @override
  Color get tertiaryRed => const Color(0xFF);
}

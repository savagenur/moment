// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
// import 'package:main_character/app/colors/app_colors.dart';

extension ToBuildContext on BuildContext {
  // AppColors get colors => AppColors.of(this);
  // AppLocalizations get locales => AppLocalizations.of(this)!;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

import 'package:flutter/material.dart';
import 'package:moment/core/constants/toast/toast_colors.dart';

class ToastType {
  /// message is `required` parameter
  final String message;

  /// color is optional, if provided null then `ToastColors` will be used
  final Color? color;

  const ToastType(this.message, [this.color]);

  static const ToastType help = ToastType('help', ToastColors.helpBlue);
  static const ToastType failure =
      ToastType('failure', ToastColors.failureRed);
  static const ToastType success =
      ToastType('success', ToastColors.successGreen);
  static const ToastType warning =
      ToastType('warning', ToastColors.warningYellow);
}
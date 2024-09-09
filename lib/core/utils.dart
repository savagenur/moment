import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/web.dart';
import 'package:moment/core/constants/toast/toast_types.dart';

final logger = Logger();

void snackBar(
  BuildContext context, {
  required String message,
  required ToastType toastType,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toastType.color,
      textColor: Colors.white,
      fontSize: 16.0);
}

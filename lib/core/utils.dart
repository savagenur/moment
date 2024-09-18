import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/web.dart';
import 'package:moment/core/constants/toast/toast_types.dart';

final logger = Logger();
final firebaseAuth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

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

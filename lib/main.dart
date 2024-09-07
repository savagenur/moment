import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moment/features/app/app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MomentApp(),
    ),
  );
}

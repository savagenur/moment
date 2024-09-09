import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moment/features/app/app.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/auth/auth_di.dart';
import 'package:moment/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  await initAuthDependencies();
  runApp(
    const ProviderScope(
      child: MomentApp(),
    ),
  );
}

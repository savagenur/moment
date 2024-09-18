import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moment/features/app/app.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/auth/auth_di.dart';
import 'package:moment/features/shift/models/shift/shift_model.dart';
import 'package:moment/features/shift/models/snapper_start_report/snapper_start_report_model.dart';
import 'package:moment/features/shift/repos/snapper_shift_repo.dart';
import 'package:moment/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAppCheck.instance.activate(
  //   // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
  //   // argument for `webProvider`
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //   // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
  //   // your preferred provider. Choose from:
  //   // 1. Debug provider
  //   // 2. Safety Net provider
  //   // 3. Play Integrity provider
  //   androidProvider: AndroidProvider.debug,
  //   // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
  //   // your preferred provider. Choose from:
  //   // 1. Debug provider
  //   // 2. Device Check provider
  //   // 3. App Attest provider
  //   // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
  //   appleProvider: AppleProvider.appAttest,
  // );
  await initDependencies();
  await initAuthDependencies();
//   await sl<ShiftRepo>().createShift(ShiftModel.snapper(
//     status: 1,
//     restaurantName: "New2",
//     startTime: DateTime.now(),
//     createdAt: DateTime.now(),
//     startReportModel: StartReportModel.snapper(
// restaurantName: "Odyssey"
//     )
//   ));
//   await sl<ShiftRepo>().setLocalShift(ShiftModel.snapper(
//     status: 1,
//     restaurantName: "Forget me not",
//     startTime: DateTime.now(),
//     createdAt: DateTime.now(),
//     startReportModel: StartReportModel.snapper(
// restaurantName: "Odyssey"
//     )
//   ));
  runApp(
    const ProviderScope(
      child: MomentApp(),
    ),
  );
}

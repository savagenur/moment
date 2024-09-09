import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moment/core/constants/design_dimensions.dart';
import 'package:moment/core/extensions/to_double_extension.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/app/routes/app_router.dart';

class InternetConnection {
  static final connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  void onInternetListener() {
    _subscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        final context = sl<AppRouter>().navigatorKey.currentContext;
        if (context == null) return;
        if (context.mounted) {
          if (connectivityResult.contains(ConnectivityResult.none)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.wifi_off_sharp,
                    color: Colors.red,
                  ),
                  DDimension.bigPadding.horizontalBox,
                  const Text("Network disconnected, please check it"),
                ],
              ),
              dismissDirection: DismissDirection.none,
              duration: const Duration(
                days: 1,
              ),
            ));
          } else {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
        }
      },
    );
  }

  // Stop listening for connectivity changes
  void dispose() {
    _subscription?.cancel();
  }
}

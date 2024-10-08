import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/app/internet/internet_connection.dart';
import 'package:moment/features/app/routes/app_router.dart';
import 'package:moment/features/app/theme/app_theme.dart';

class MomentApp extends HookWidget {
  const MomentApp({super.key});
  @override
  Widget build(BuildContext context) {
    final appRouter = sl<AppRouter>();
    useEffect(() {
      sl<InternetConnection>().onInternetListener();
      return sl<InternetConnection>().dispose;
    }, []);
    return MaterialApp.router(
      builder: EasyLoading.init(),
      routerConfig: appRouter.config(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
    );
  }
}

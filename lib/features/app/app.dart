import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moment/features/app/routes/provider/app_router_provider.dart';
import 'package:moment/features/app/theme/app_theme.dart';
import 'package:moment/features/auth/views/sign_in/sign_in_page.dart';

class MomentApp extends ConsumerWidget {
  const MomentApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
    );
  }
}


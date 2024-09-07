import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../app_router.dart';

part 'app_router_provider.g.dart'; // Generated code for the provider

@riverpod
Raw<AppRouter> appRouter(AppRouterRef ref) {
  return AppRouter();
}

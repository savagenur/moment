import 'package:auto_route/auto_route.dart';
import 'package:moment/features/app/routes/app_router.gr.dart';
import 'package:moment/features/app/routes/guards/auth_guard.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SnapperNavigationRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: SignInRoute.page,
        ),
        AutoRoute(
          page: SnapperShiftStartRoute.page,
        ),
        AutoRoute(
          page: SnapperShiftProcessRoute.page,
        ),
        AutoRoute(
          page: SnapperShiftStartReportRoute.page,
        ),
        AutoRoute(
          page: SnapperShiftEndRoute.page,
        ),
      ];
  @override
  List<AutoRouteGuard> get guards => [
        const AuthGuard(),
      ];
}

import 'package:auto_route/auto_route.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/app/routes/app_router.gr.dart';
import 'package:moment/features/auth/repos/auth_repo.dart';

class AuthGuard extends AutoRouteGuard {
  const AuthGuard();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (resolver.route.name == SignInRoute.name) {
      // Allow the navigation to SignInRoute without checks
      resolver.next(true);
      return;
    }
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    final isAuthenticated = sl<AuthRepo>().isAuthenticated;
    if (isAuthenticated) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      // tip: use resolver.redirect to have the redirected route
      // automatically removed from the stack when the resolver is completed
      resolver.redirect(SignInRoute());
    }
  }
}

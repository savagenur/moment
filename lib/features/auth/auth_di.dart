import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/auth/repos/auth_repo.dart';

Future<void> initAuthDependencies() async {
  sl.registerLazySingleton(
    () => AuthRepo(),
  );
}

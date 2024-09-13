import 'package:get_it/get_it.dart';
import 'package:moment/features/app/internet/internet_connection.dart';
import 'package:moment/features/app/repos/database/database_helper.dart';
import 'package:moment/features/app/routes/app_router.dart';
import 'package:moment/features/shift/repos/snapper_shift_repo.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerSingleton(AppRouter());
  sl.registerSingleton(
    InternetConnection(),
  );
  sl.registerLazySingleton(
    () => SnapperShiftRepo(),
  );
  sl.registerSingleton(DatabaseHelper());
}

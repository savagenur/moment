import 'package:fpdart/fpdart.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/app/routes/app_router.dart';
import 'package:moment/features/auth/models/user/user_model.dart';
import 'package:moment/features/auth/repos/auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  final _navigatorKey = sl<AppRouter>().navigatorKey;
  final AuthRepo _authRepo = sl<AuthRepo>();
  @override
  AsyncValue<UserModel?>? build() {
    return null;
  }

  FutureOr<void> signInWithEmailAndPassword(
      String email, String password) async {
    state = const AsyncValue.loading();
    final res = await _authRepo.signInWithEmailAndPassword(email, password);
    // final val = switch (res) {
    //   Left(value: final l) => state =
    //       AsyncValue.error(l.message!, StackTrace.current),
    //   Right(value: final r) => state = AsyncValue.data(r),
    // };
    switch (res) {
      case Left():

        state = AsyncValue.error(res.value.message!, StackTrace.current);
        break;
      case Right():
        state = AsyncValue.data(res.value);
        break;
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) {
    return _authRepo.createUserWithEmailAndPassword(email, password);
  }

  Future<void> signOut() async {
    try {
      await _authRepo.signOut();
      state = AsyncValue.data(null);
    } catch (_) {
      state = AsyncValue.error("Error with sign out!", StackTrace.current);
    }
  }
}

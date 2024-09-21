import 'dart:developer';

import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/auth/models/user/user_model.dart';
import 'package:moment/features/auth/repos/auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  final AuthRepo _authRepo = sl<AuthRepo>();
  @override
  AsyncValue<UserModel?>? build() {
    return null;
  }

  FutureOr<void> signInWithEmailAndPassword(
      String email, String password) async {
    state = const AsyncValue.loading();
    final res = await _authRepo.signInWithEmailAndPassword(email, password);

    res.fold(
      (l) => state = AsyncValue.error(l.message!, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    final res = await _authRepo.createUserWithEmailAndPassword(email, password);
    res.fold(
      (l) => state = AsyncValue.error(l.message!, StackTrace.current),
      (r) {
        log("User created");
      },
    );
  }

  Future<void> signOut() async {
    final res = await _authRepo.signOut();
    res.fold(
      (l) => state =
          AsyncValue.error("Sign out: ${l.message}", StackTrace.current),
      (r) => state = const AsyncValue.data(null),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:moment/core/failure/failure.dart';
import 'package:moment/core/utils.dart';
import 'package:moment/features/app/injection_container.dart';
import 'package:moment/features/app/routes/app_router.dart';
import 'package:moment/features/auth/models/user/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AuthRepo {
  final _firebaseAuth = FirebaseAuth.instance;
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      logger.e('Error: $e');
    }
  }

  User? get currentUser => _firebaseAuth.currentUser;
  bool get isAuthenticated => _firebaseAuth.currentUser != null;
  String? get getUserId => _firebaseAuth.currentUser?.uid;

  Future<Either<AppFailure, UserModel>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Sign-in successful
      return Right(
        UserModel(
          email: userCredential.user?.email,
          username: userCredential.user?.displayName,
        ),
      );
    } on FirebaseAuthException catch (e) {

      return Left(
        AppFailure(
          message: e.message,
        ),
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {}
  }
}

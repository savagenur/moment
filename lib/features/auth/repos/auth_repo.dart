import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:moment/core/enums/user_role.dart';
import 'package:moment/core/failure/failure.dart';
import 'package:moment/core/utils.dart';
import 'package:moment/features/auth/models/user/user_model.dart';

class AuthRepo {
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = UserModel(
        id: getUserId,
        email: email,
        name: "Nurbolot",
        role: UserRole.snapper.text,
      );
      // Sign-in successful
      await firestore.collection("users").doc(getUserId).set(
            user.toJson(),
          );
    } catch (e) {
      logger.e('Error: $e');
    }
  }

  User? get currentUser => firebaseAuth.currentUser;
  bool get isAuthenticated => firebaseAuth.currentUser != null;
  String? get getUserId => firebaseAuth.currentUser?.uid;

  Future<Either<AppFailure, UserModel>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = UserModel(
        id: getUserId,
        email: userCredential.user?.email,
        name: "Nurbolot",
        role: UserRole.snapper.text,
      );
      // Sign-in successful
      await firestore.collection("users").doc(getUserId).set(
            user.toJson(),
            SetOptions(
              merge: true,
            ),
          );
      return Right(
        user,
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
      await firebaseAuth.signOut();
    } catch (_) {}
  }
}

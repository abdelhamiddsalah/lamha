import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:lamha/features/authintecation/data/models/user_model.dart';

class FirebaseAuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // تسجيل الدخول
  Future<Either<String, UserModel>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user != null) {
        return Right(UserModel(
          userid: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? '',
          password: password,
        ));
      } else {
        return const Left('User is null');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return const Left('Wrong password provided for that user.');
      } else {
        return Left(e.message ?? 'An unknown error occurred');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  // إنشاء مستخدم جديد
  Future<Either<String, UserCredential>> createUser({
    required String email,
    required String password,
   required String name
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return const Left('The account already exists for that email.');
      } else {
        return Left(e.message ?? 'An unknown error occurred');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  // المستخدم الحالي (نمرر الباسورد من الخارج)
  Future<Either<String, UserModel>> getCurrentUser({String? password}) async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        return Right(UserModel(
          userid: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? '',
          password: password ?? '',
        ));
      } else {
        return const Left('No user is currently signed in');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  // إعادة تعيين كلمة المرور
  Future<Either<String, bool>> resetPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'Failed to send password reset email');
    } catch (e) {
      return Left(e.toString());
    }
  }

  // نعيد استخدام reset
  Future<Either<String, bool>> forgetPassword({required String email}) async {
    return resetPassword(email: email);
  }

  // تسجيل الخروج
  Future<Either<String, bool>> signOut() async {
    try {
      await auth.signOut();
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }


   Future<void> confirmPasswordReset({
    required String oobCode,
    required String newPassword,
  }) async {
    await auth.confirmPasswordReset(
      code: oobCode,
      newPassword: newPassword,
    );
  }
}
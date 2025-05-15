import 'package:dartz/dartz.dart';
import 'package:lamha/core/services/firebase_auth_services.dart';
import 'package:lamha/features/authintecation/data/models/user_model.dart';
import 'package:lamha/features/authintecation/domain/entities/user_entity.dart';
import 'package:lamha/features/authintecation/domain/repositories/user_repositry.dart';

class UserRepositoryImpl implements UserRepositry {
  final FirebaseAuthServices firebaseAuthServices;

  UserRepositoryImpl(this.firebaseAuthServices);

  @override
  Future<Either<String, UserEntity>> resetPassword({required String email}) async {
    final result = await firebaseAuthServices.resetPassword(email: email);
    return result.fold(
      (error) => Left(error),
      (success) {
        if (success) {
          return Right(UserModel(
            userid: '',
            email: email,
            name: '',
            password: '',
          ));
        } else {
          return const Left('Failed to reset password');
        }
      },
    );
  }

  @override
  Future<Either<String, UserEntity>> forgetPassword({required String email}) async {
    final result = await firebaseAuthServices.forgetPassword(email: email);
    return result.fold(
      (error) => Left(error),
      (success) {
        if (success) {
          return Right(UserModel(
            userid: '',
            email: email,
            name: '',
            password: '',
          ));
        } else {
          return const Left('Failed to send forget password email');
        }
      },
    );
  }

  @override
  Future<Either<String, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    return await firebaseAuthServices.loginUser(
      email: email,
      password: password,
    );
  }

  @override
  Future<Either<String, bool>> signOut() async {
    return await firebaseAuthServices.signOut();
  }

  @override
  Future<Either<String, UserEntity>> signUp({
    required String email,
    required String password,
  }) async {
    final result = await firebaseAuthServices.createUser(
      email: email,
      password: password,
    );

    return result.fold(
      (error) => Left(error),
      (userCredential) {
        final userModel = UserModel(
          userid: userCredential.user?.uid ?? '',
          email: userCredential.user?.email ?? '',
          password: password,
          name: userCredential.user?.displayName ?? '',
        );
        return Right(userModel);
      },
    );
  }
  
  @override
  Future<Either<String, UserEntity>> getCurrentUser() async {
    return await firebaseAuthServices.getCurrentUser();
  }
}
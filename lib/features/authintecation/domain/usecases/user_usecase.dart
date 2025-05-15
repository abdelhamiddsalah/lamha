import 'package:dartz/dartz.dart';
import 'package:lamha/features/authintecation/domain/entities/user_entity.dart';
import 'package:lamha/features/authintecation/domain/repositories/user_repositry.dart';

class UserUsecase {
  final UserRepositry userRepositry;
  UserUsecase({required this.userRepositry});

  Future<Either<String, UserEntity>> signUp({required String email,required String password,}) => userRepositry.signUp(email: email, password: password,);
  Future<Either<String, UserEntity>> signIn({required String email,required String password,}) => userRepositry.signIn(email: email, password: password,);
  Future<Either<String, UserEntity>> resetPassword({required String email}) => userRepositry.resetPassword(email: email,);
  Future<Either<String, UserEntity>> forgetPassword({required String email}) => userRepositry.forgetPassword(email: email,);
  Future<Either<String, UserEntity>> getCurrentUser() => userRepositry.getCurrentUser();
  Future<void> signOut() => userRepositry.signOut();
}
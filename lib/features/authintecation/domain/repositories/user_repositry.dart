import 'package:dartz/dartz.dart';
import 'package:lamha/features/authintecation/domain/entities/user_entity.dart';

abstract class UserRepositry {
  Future<Either<String, UserEntity>> signUp({required String email, required String password});
  Future<Either<String, UserEntity>> signIn({required String email, required String password});
  Future<Either<String, bool>> signOut();
  Future<Either<String, UserEntity>> getCurrentUser();
  Future<Either<String, UserEntity>> resetPassword({required String email});
  Future<Either<String, UserEntity>> forgetPassword({required String email});
}
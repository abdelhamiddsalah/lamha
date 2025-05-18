import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lamha/core/services/firebase_auth_services.dart';
import 'package:lamha/core/services/firebase_store_services.dart';
import 'package:lamha/features/authintecation/data/models/user_model.dart';
import 'package:lamha/features/authintecation/domain/entities/user_entity.dart';
import 'package:lamha/features/authintecation/domain/repositories/user_repositry.dart';

class UserRepositoryImpl implements UserRepositry {
  final FirebaseAuthServices firebaseAuthServices;
  final FirebaseStoreServices firebaseStoreServices;
  
  UserRepositoryImpl(this.firebaseAuthServices, this.firebaseStoreServices);

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
    required String name,
  }) async {
    final result = await firebaseAuthServices.createUser(
      email: email,
      password: password,
      name: name,
    );

    return result.fold(
      (error) => Left(error),
      (userCredential) async {
        try {
          // إنشاء نموذج المستخدم
          final userModel = UserModel(
            userid: userCredential.user?.uid ?? '',
            email: userCredential.user?.email ?? '',
            password: password, // لن يتم تخزينه في Firestore
            name: name , // استخدام الاسم إن وجد
          );
          
          // حفظ بيانات المستخدم في Firestore مع التاريخ
          await firebaseStoreServices.saveUserToCollection(userModel);
          
          // تحديث اسم المستخدم في Firebase Auth إذا تم توفيره
          if (name != null && name.isNotEmpty && userCredential.user != null) {
            await userCredential.user!.updateDisplayName(name);
          }
          
          return Right(userModel);
        } catch (e) {
          return Left('حدث خطأ أثناء حفظ بيانات المستخدم: ${e.toString()}');
        }
      },
    );
  }
  
  @override
  Future<Either<String, UserEntity>> getCurrentUser() async {
    return await firebaseAuthServices.getCurrentUser();
  }
  
  @override
  Future<Either<String, bool>> confirmPasswordReset({
    required String oobCode,
    required String newPassword,
  }) async {
    try {
      await firebaseAuthServices.confirmPasswordReset(
        oobCode: oobCode,
        newPassword: newPassword,
      );
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      return Left(_handleFirebaseAuthError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }
}

String _handleFirebaseAuthError(FirebaseAuthException e) {
  switch (e.code) {
    case 'user-not-found':
      return 'لا يوجد مستخدم بهذا البريد الإلكتروني';
    case 'wrong-password':
      return 'كلمة المرور غير صحيحة';
    case 'email-already-in-use':
      return 'البريد الإلكتروني مستخدم بالفعل';
    case 'weak-password':
      return 'كلمة المرور ضعيفة';
    case 'operation-not-allowed':
      return 'العملية غير مسموح بها';
    case 'invalid-email':
      return 'البريد الإلكتروني غير صالح';
    case 'user-disabled':
      return 'تم تعطيل حساب المستخدم';
    case 'expired-action-code':
      return 'انتهت صلاحية رمز إعادة تعيين كلمة المرور';
    case 'invalid-action-code':
      return 'رمز إعادة تعيين كلمة المرور غير صالح';
    default:
      return 'حدث خطأ أثناء المصادقة: ${e.code}';
  }
}
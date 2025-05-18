import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lamha/features/authintecation/domain/entities/user_entity.dart';
import 'package:lamha/features/authintecation/domain/usecases/user_usecase.dart';

part 'authintecation_state.dart';

class AuthintecationCubit extends Cubit<AuthintecationState> {
  final UserUsecase userUsecase;
  AuthintecationCubit(this.userUsecase) : super(AuthintecationInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  final namecontroller = TextEditingController();

  String? _oobCode;

  void setOobCode(String code) {
    _oobCode = code;
  }
      
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthintecationLoading());
    final result = await userUsecase.signIn(email: email, password: password);
    result.fold(
      (l) => emit(AuthintecationError(message: l)), 
      (r) => emit(AuthintecationLoaded(user: r))
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    emit(AuthintecationLoading());
    // إضافة اسم المستخدم من التحكم في النص
    final result = await userUsecase.signUp(
      email: email, 
      password: password,
      name: namecontroller.text.trim(), // إضافة اسم المستخدم
    );
    result.fold(
      (l) => emit(AuthintecationError(message: l)), 
      (r) => emit(AuthintecationLoaded(user: r))
    );
  }

  Future<void> resetPassword({required String email}) async {
    emit(AuthintecationLoading());
    final result = await userUsecase.resetPassword(email: email);
    result.fold(
      (l) => emit(AuthintecationError(message: l)), 
      (r) => emit(AuthintecationLoaded(user: r))
    );
  }

  Future<void> forgetPassword({required String email}) async {
    emit(AuthintecationLoading());
    final result = await userUsecase.forgetPassword(email: email);
    result.fold(
      (l) => emit(AuthintecationError(message: l)),
      (r) => emit(ForgetPasswordSuccess()),
    );
  }
  
  Future<void> getCurrentUser() async {
    emit(AuthintecationLoading());
    final result = await userUsecase.getCurrentUser();
    result.fold(
      (l) => emit(AuthintecationError(message: l)), 
      (r) => emit(AuthintecationLoaded(user: r))
    );
  }

  Future<void> signOut() async {
    await userUsecase.signOut();
    emit(AuthintecationSuccess());
  }
  
  Future<void> confirmPasswordReset({required String newPassword}) async {
    if (_oobCode == null) {
      emit(AuthintecationError(message: 'رمز إعادة تعيين كلمة المرور غير متوفر'));
      return;
    }
    
    emit(AuthintecationLoading());
    final result = await userUsecase.confirmPasswordReset(
      oobCode: _oobCode!,
      newPassword: newPassword
    );
    
    result.fold(
      (l) => emit(AuthintecationError(message: l)),
      (r) => emit(AuthintecationSuccess())
    );
  }

  @override
  Future<void> close() {
    // تنظيف التحكمات عند إغلاق الـ Cubit
    emailController.dispose();
    passwordController.dispose();
    password2Controller.dispose();
    namecontroller.dispose();
    return super.close();
  }
}
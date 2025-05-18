import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lamha/core/styles/app_colors.dart';
import 'package:lamha/features/authintecation/presentation/cubit/authintecation_cubit.dart';
import 'package:lamha/features/authintecation/presentation/widgets/signup_view_body.dart';
import 'package:lamha/getit.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthintecationCubit>(),
      child: BlocConsumer<AuthintecationCubit, AuthintecationState>(
        listener: (context, state) {
          if (state is AuthintecationLoaded) {
            // عند النجاح في التسجيل
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم التسجيل بنجاح')),
            );
            // يمكنك التوجيه لصفحة تسجيل الدخول أو الصفحة الرئيسية
            // مثال: GoRouter.of(context).go(Routes.login);
          } else if (state is AuthintecationError) {
            // عند حدوث خطأ، نعرض حوار بدلاً من الـ SnackBar
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                title: const Text(
                  'حدث خطأ',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.right,
                ),
                actions: [
                  TextButton(
                    onPressed: () => GoRouter.of(context).pop(),
                    child: const Text('حسناً',
                        style: TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          return SignupViewBody(isLoading: state is AuthintecationLoading);
        },
      ),
    );
  }
}
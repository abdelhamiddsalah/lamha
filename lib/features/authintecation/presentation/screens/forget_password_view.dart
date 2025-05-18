import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lamha/core/routing/routes.dart';
import 'package:lamha/features/authintecation/presentation/cubit/authintecation_cubit.dart';
import 'package:lamha/features/authintecation/presentation/widgets/forget_password_view_body.dart';
import 'package:lamha/getit.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthintecationCubit>(),
      child: BlocConsumer<AuthintecationCubit, AuthintecationState>(
        listener: (context, state) {
            if (state is ForgetPasswordSuccess) {
            GoRouter.of(context).go(Routes.sendemail);
            // يمكنك التوجيه لصفحة أخرى بعد تسجيل الدخول
          } else if (state is AuthintecationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return ForgetPasswordViewBody(isLoading: state is AuthintecationLoading);
        },
      ),
    );
  }
}

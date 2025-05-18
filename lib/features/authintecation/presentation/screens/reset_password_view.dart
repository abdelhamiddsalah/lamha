
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamha/features/authintecation/presentation/cubit/authintecation_cubit.dart';
import 'package:lamha/features/authintecation/presentation/widgets/reset_password_view_body.dart';
import 'package:lamha/getit.dart';

class ResetPasswordView extends StatelessWidget {
  final String? oobCode;
  
  const ResetPasswordView({super.key, this.oobCode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthintecationCubit>(),
      child: ResetPasswordViewBody(oobCode: oobCode),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamha/features/authintecation/presentation/cubit/authintecation_cubit.dart';
import 'package:lamha/features/authintecation/presentation/widgets/signup_view_body.dart';
import 'package:lamha/getit.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthintecationCubit>(),
      child: SignupViewBody(),
    );
  }
}

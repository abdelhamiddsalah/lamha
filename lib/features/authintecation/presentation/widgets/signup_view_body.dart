import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamha/core/styles/app_colors.dart';
import 'package:lamha/core/widgets/custom_button.dart';
import 'package:lamha/core/widgets/custom_textformfield.dart';
import 'package:lamha/features/authintecation/presentation/cubit/authintecation_cubit.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: context.read<AuthintecationCubit>().formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              CustomTextformfield(),
              CustomTextformfield(),
              CustomTextformfield(),
              CustomTextformfield(),
              CustomButton(color: AppColors.mainColor, width: double.infinity, text: 'تسجيل الدخول', textcolor: Colors.white,)
            ],
          ),
        ),
        
        ),
    );
  }
}
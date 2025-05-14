import 'package:flutter/material.dart';
import 'package:lamha/core/styles/app_colors.dart';
import 'package:lamha/core/widgets/custom_button.dart';
import 'package:lamha/core/widgets/custom_textformfield.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: CustomButton(color: AppColors.mainColor, width: double.infinity, text: 'text', textcolor: Colors.white,),
          ),
          CustomTextformfield(controller: null, hinttext: 'hinttext', suffixIcon: null,)
        ],
      ),
    );
  }
}
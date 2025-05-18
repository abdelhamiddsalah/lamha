import 'package:flutter/material.dart';
import 'package:lamha/core/styles/app_colors.dart';
import 'package:lamha/core/styles/text_styles.dart';

class CustomTextformfield extends StatelessWidget {
  const CustomTextformfield({super.key, this.controller, this.hinttext, this.suffixIcon, this.keyboardType, this.textInputAction, this.validator});
  final TextEditingController? controller;
  final String? hinttext;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
 final bool obscureText = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      textInputAction: textInputAction,
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,   
      decoration: InputDecoration(
        hintText: hinttext,
        suffixIcon: suffixIcon,
        hintStyle: TextStyles.titleButton.copyWith(
          color: Colors.grey,
          fontSize: 17,
          fontWeight: FontWeight.w400
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: AppColors.mainColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: AppColors.mainColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: AppColors.mainColor),
        ),
    ));
  }
}
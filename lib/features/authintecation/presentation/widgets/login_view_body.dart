import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lamha/constants/images.dart';
import 'package:lamha/core/routing/routes.dart';
import 'package:lamha/core/styles/app_colors.dart';
import 'package:lamha/core/styles/text_styles.dart';
import 'package:lamha/core/widgets/custom_appbar.dart';
import 'package:lamha/core/widgets/custom_button.dart';
import 'package:lamha/core/widgets/custom_textformfield.dart';
import 'package:lamha/features/authintecation/presentation/cubit/authintecation_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginViewBody extends StatefulWidget {
  final bool isLoading;

  const LoginViewBody({super.key, required this.isLoading});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = context.read<AuthintecationCubit>();

    return ModalProgressHUD(
      inAsyncCall: widget.isLoading,
      child: Scaffold(
        appBar: CustomAppbar(text: 'تسجيل دخول'),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.02,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'app_logo',
                          child: Container(
                            width: size.width * 0.25,
                            height: size.width * 0.25,
                            constraints: const BoxConstraints(
                              maxWidth: 120,
                              maxHeight: 120,
                              minWidth: 80,
                              minHeight: 80,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.mainColor.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(Assets.imagesLogo),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        Text(
                          'تسجيل دخول',
                          style: TextStyles.titleButton.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainColor,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Text(
                          'أدخل بياناتك للانضمام إلينا',
                          style: TextStyles.titleButton.copyWith(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        CustomTextformfield(
                          hinttext: 'الإيميل',
                          suffixIcon: const Icon(Icons.email_outlined, color: AppColors.mainColor),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          controller: cubit.emailController,
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomTextformfield(
                          hinttext: 'كلمة المرور',
                          controller: cubit.passwordController,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.visibility_outlined, color: AppColors.mainColor),
                            onPressed: () {
                              // إظهار أو إخفاء الباسورد
                            },
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                GoRouter.of(context).push(Routes.forgetPassword);
                              },
                              child: Text(
                                'نسيت كلمة المرور؟',
                                style: TextStyles.titleButton.copyWith(color: Colors.grey, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03),
                        CustomButton(
                          color: AppColors.mainColor,
                          width: double.infinity,
                          text: 'تسجيل الدخول',
                          textcolor: Colors.white,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.signIn(email: cubit.emailController.text, password: cubit.passwordController.text,);
                            }
                          },
                        
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'هل لديك حساب؟',
                              style: TextStyles.titleButton.copyWith(color: Colors.grey, fontSize: 14),
                            ),
                            TextButton(
                              onPressed: () {
                                GoRouter.of(context).push(Routes.signup);
                              },
                              child: Text(
                                'تسجيل الدخول',
                                style: TextStyles.titleButton.copyWith(
                                  color: AppColors.mainColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

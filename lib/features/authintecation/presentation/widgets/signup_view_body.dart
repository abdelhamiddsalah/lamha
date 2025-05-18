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
import 'package:lamha/features/authintecation/presentation/widgets/social_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key, required this.isLoading});
  final bool isLoading;
  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

  
      
        return ModalProgressHUD(
          inAsyncCall: widget.isLoading,
          progressIndicator: CircularProgressIndicator(
            color: AppColors.mainColor,
          ),
          child: Scaffold(
            appBar: CustomAppbar(text: 'تسجيل حساب جديد'),
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              'إنشاء حساب جديد',
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
                              hinttext: 'اسم المستخدم',
                              controller: context.read<AuthintecationCubit>().namecontroller,
                              suffixIcon: Icon(
                                Icons.person_outline,
                                color: AppColors.mainColor,
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال اسم المستخدم';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: size.height * 0.02),

                            CustomTextformfield(
                              hinttext: 'الإيميل',
                              controller: context.read<AuthintecationCubit>().emailController,
                              suffixIcon: Icon(
                                Icons.email_outlined,
                                color: AppColors.mainColor,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال البريد الإلكتروني';
                                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return 'يرجى إدخال بريد إلكتروني صحيح';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: size.height * 0.02),

                            CustomTextformfield(
                              hinttext: 'كلمة المرور',
                              controller: context.read<AuthintecationCubit>().passwordController,
                            //  obscureText: !_isPasswordVisible,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible ? Icons.visibility : Icons.visibility_outlined,
                                  color: AppColors.mainColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال كلمة المرور';
                                } else if (value.length < 6) {
                                  return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: size.height * 0.03),

                           

                            CustomButton(
                              color: AppColors.mainColor,
                              width: double.infinity,
                              text: 'تسجيل الدخول',
                              textcolor: Colors.white,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthintecationCubit>().signUp(
                                    email: context.read<AuthintecationCubit>().emailController.text.trim(),
                                    password: context.read<AuthintecationCubit>().passwordController.text,
                                  );
                                }
                              },
                            ),

                            SizedBox(height: size.height * 0.02),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'هل لديك حساب؟',
                                  style: TextStyles.titleButton.copyWith(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    GoRouter.of(context).push(Routes.login);
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

                            SizedBox(height: size.height * 0.02),

                            Row(
                              children: [
                                Expanded(child: Divider(color: Colors.grey.shade300)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'أو',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                Expanded(child: Divider(color: Colors.grey.shade300)),
                              ],
                            ),

                            SizedBox(height: size.height * 0.02),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SocialLoginButton(
                                  onTap: () {},
                                  image: Assets.imagesFacebook,
                                  tooltip: 'تسجيل الدخول باستخدام Facebook',
                                ),
                                SizedBox(width: size.width * 0.05),
                                SocialLoginButton(
                                  onTap: () {},
                                  image: Assets.imagesBluegooglew,
                                  tooltip: 'تسجيل الدخول باستخدام Google',
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
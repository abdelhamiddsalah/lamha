import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamha/constants/images.dart';
import 'package:lamha/core/styles/app_colors.dart';
import 'package:lamha/core/styles/text_styles.dart';
import 'package:lamha/core/widgets/custom_appbar.dart';
import 'package:lamha/core/widgets/custom_button.dart';
import 'package:lamha/core/widgets/custom_textformfield.dart';
import 'package:lamha/features/authintecation/presentation/cubit/authintecation_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key, required this.isLoading});
  final bool isLoading;
  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return ModalProgressHUD(
       inAsyncCall: widget.isLoading,
      child: Scaffold(
        appBar:  CustomAppbar(text: 'استعادة كلمة المرور',),
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
                    constraints: BoxConstraints(
                      maxWidth: 450, // حد أقصى للعرض لشاشات الأجهزة الكبيرة
                    ),
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
                        
                        // عنوان الصفحة
                        Text(
                          'نسيت كلمة المرور',
                          style: TextStyles.titleButton.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainColor,
                          ),
                        ),
                        
                        SizedBox(height: size.height * 0.02),
                        
                        // نص توضيحي
                        Text(
                          'أدخل الإيميل',
                          style: TextStyles.titleButton.copyWith(
                            color: Colors.grey,
                            
                            fontSize: 14,
                          ),
                        ),
                        
                        SizedBox(height: size.height * 0.04),
                        
                        CustomTextformfield(
                          hinttext: 'الإيميل',
                          suffixIcon:  Icon(Icons.email_outlined,color:AppColors.mainColor ,),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                           controller: context.read<AuthintecationCubit>().emailController,
                        ),
                        SizedBox(height: size.height * 0.03),
                        
                        // زر التسجيل
                        CustomButton(
                          color: AppColors.mainColor,
                          width: double.infinity,
                          text: 'ارسال',
                          textcolor: Colors.white,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthintecationCubit>().forgetPassword(email: context.read<AuthintecationCubit>().emailController.text);
                            }
                          },
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
 
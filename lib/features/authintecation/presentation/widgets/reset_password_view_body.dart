import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamha/constants/images.dart';
import 'package:lamha/core/styles/app_colors.dart';
import 'package:lamha/core/styles/text_styles.dart';
import 'package:lamha/core/widgets/custom_appbar.dart';
import 'package:lamha/core/widgets/custom_button.dart';
import 'package:lamha/core/widgets/custom_textformfield.dart';
import 'package:lamha/features/authintecation/presentation/cubit/authintecation_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:lamha/core/routing/routes.dart';

class ResetPasswordViewBody extends StatefulWidget {
  final String? oobCode;
  
  const ResetPasswordViewBody({super.key, this.oobCode});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  
  // Create local TextEditingController instances
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    // Store the oobCode in the cubit if provided
    if (widget.oobCode != null) {
      print("ResetPasswordView received oobCode: ${widget.oobCode}");
      context.read<AuthintecationCubit>().setOobCode(widget.oobCode!);
    } else {
      print("No oobCode provided to ResetPasswordView");
    }
  }
  
  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: CustomAppbar(text: 'تعيين كلمة المرور',),
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthintecationCubit, AuthintecationState>(
        listener: (context, state) {
          if (state is AuthintecationLoading) {
            setState(() {
              _isLoading = true;
            });
          } else {
            setState(() {
              _isLoading = false;
            });
            
            if (state is AuthintecationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is AuthintecationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تعيين كلمة المرور بنجاح')),
              );
              // Navigate to login page
              context.go(Routes.login);
            }
          }
        },
        builder: (context, state) {
          return SafeArea(
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
                      constraints: const BoxConstraints(
                        maxWidth: 450, // Max width for larger devices
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
                          Text(
                            'تعيين كلمة المرور',
                            style: TextStyles.titleButton.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor,
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'أدخل كلمة المرور الجديدة',
                            style: TextStyles.titleButton.copyWith(
                              color: Colors.grey,        
                              fontSize: 14,
                            ),
                          ),         
                          SizedBox(height: size.height * 0.04),          
                          CustomTextformfield(
                            hinttext: 'كلمة المرور',
                            
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.mainColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            keyboardType: TextInputType.visiblePassword,
                          //  obscureText: !_isPasswordVisible,
                            textInputAction: TextInputAction.next,
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال كلمة المرور';
                              } else if (value.length < 6) {
                                return 'كلمة المرور يجب أن تكون على الأقل 6 أحرف';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: size.height * 0.03),
                          CustomTextformfield(
                            hinttext: 'تأكيد كلمة المرور',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.mainColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                            keyboardType: TextInputType.visiblePassword,
                        //    obscureText: !_isConfirmPasswordVisible,
                            textInputAction: TextInputAction.done,
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى تأكيد كلمة المرور';
                              } else if (value != _passwordController.text) {
                                return 'كلمات المرور غير متطابقة';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: size.height * 0.03),
                          // Submit button
                          CustomButton(
                            color: AppColors.mainColor,
                            width: double.infinity,
                            text: _isLoading ? 'جاري المعالجة...' : 'تعيين كلمة المرور',
                            textcolor: Colors.white,
                            onTap: _isLoading ? null : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<AuthintecationCubit>().confirmPasswordReset(
                                  newPassword: _passwordController.text,
                                );
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
          );
        },
      ),
    );
  }
}
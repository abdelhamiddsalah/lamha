import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamha/constants/images.dart';
import 'package:lamha/core/styles/app_colors.dart';
import 'package:lamha/core/widgets/custom_button.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.mainColor, Colors.white],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: Column(
          children: [
            SizedBox(height: 80.h),
            Container(
              width: 200,
              height: 200,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: Offset(0, 10), // اتجاه الظل: للأسفل
                  ),
                ],
              ),

              child: Image.asset(Assets.imagesLogo),
            ),
            Text(
              textAlign: TextAlign.center,

              ' لمحه  ',
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              textAlign: TextAlign.center,

              'تحدي المعرفه  ',
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Cairo',
              ),
            ),
             SizedBox(height: 80.h),
            CustomButton(
              color: AppColors.mainColor,
              width: double.infinity,
              text: 'تسجيل الدخول',
              textcolor: Colors.white,
              border: Border.all(color: AppColors.mainColor),
              
            ),
             SizedBox(height: 60.h),
              CustomButton(
              color: Colors.white,
              width: double.infinity,
              text: ' انشاء حساب',
              border: Border.all(color: AppColors.mainColor),
              textcolor:  AppColors.mainColor,
            ),
          ],
        ),
      ),
    );
  }
}

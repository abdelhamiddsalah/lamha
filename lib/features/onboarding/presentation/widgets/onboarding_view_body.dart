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
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 80.h),
            Container(
              width: 180.h,
              height: 180.h,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.01),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  Assets.imagesLogo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
           
              
            Text(
              ' لَمْحَةٌ  ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'تحدي المعرفه  ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
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
              textcolor: AppColors.mainColor,
            ),
          ],
        ),
      ),
    );
  }
}

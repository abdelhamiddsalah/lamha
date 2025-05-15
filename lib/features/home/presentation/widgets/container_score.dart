import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamha/core/styles/app_colors.dart';
import 'package:lamha/core/styles/text_styles.dart';
import 'package:lamha/features/home/presentation/widgets/score_slider.dart';

class ContainerScore extends StatelessWidget {
  const ContainerScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        color: AppColors.mainColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تحدي اليوم',
              style: TextStyles.text24.copyWith(
                color: Colors.black,
               
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'أكمل 3 مسابقات واربح 50 نقطة إضافية',
              style: TextStyles.text18.copyWith(
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 20.h),
            const ScoreSlider(),
          ],
        ),
      ),
    );
  }
}

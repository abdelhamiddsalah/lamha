import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamha/constants/images.dart';
import 'package:lamha/core/styles/app_colors.dart';
import 'package:lamha/core/styles/text_styles.dart';

class ContainerQuiz extends StatelessWidget {
  const ContainerQuiz({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110.h,
      decoration: BoxDecoration(
        color: AppColors.mainColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 70.h,
              height: 70.h,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  Assets.imagesScoreRemovebgPreview,
                  width: 10.h,
                  height: 10.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' تاريخ و حضارة',
                  style: TextStyles.text21.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' 25 مسابقة',
                  style: TextStyles.text16.copyWith(color: Colors.grey.shade600),
                ),
              ],
            ),
            Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
          ],
        ),
      ),
    );
  }
}

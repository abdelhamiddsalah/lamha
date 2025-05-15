import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamha/core/styles/text_styles.dart';
import 'package:lamha/features/home/presentation/widgets/container_quiz.dart';
import 'package:lamha/features/home/presentation/widgets/container_score.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomScrollView(
        slivers: [
          // الجزء العلوي الثابت
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مرحبا مصلحي !',
                  style: TextStyles.text28.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'سعيدون بعودتك ✨',
                  style: TextStyles.text24.copyWith(color: Colors.grey.shade600),
                ),
                SizedBox(height: 16.h),
                const ContainerScore(),
                SizedBox(height: 24.h),
                Text(
                  'فئات المسابقات',
                  style: TextStyles.text28.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),

          // اللستة الديناميكية
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: const ContainerQuiz(),
                );
              },
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}

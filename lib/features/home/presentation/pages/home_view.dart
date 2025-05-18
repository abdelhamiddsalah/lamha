import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lamha/core/styles/app_colors.dart';
import 'package:lamha/core/styles/text_styles.dart';
import 'package:lamha/features/home/presentation/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title:   
            Text(
              ' لَمْحَةٌ  ',
              textAlign: TextAlign.center,
              style: TextStyles.text30.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
      ),
      body: HomeViewBody(),
    );
  }
}
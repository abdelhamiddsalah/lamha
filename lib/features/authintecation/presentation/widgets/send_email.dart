import 'package:flutter/material.dart';
import 'package:lamha/constants/images.dart';
import 'package:lamha/core/styles/text_styles.dart';

class SendEmail extends StatelessWidget {
  const SendEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        backgroundColor: Colors.white,
        title:  Text('رابط إعادة تعيين كلمة المرور',style: TextStyles.titleButton.copyWith(color: Colors.black),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // صورة التأكيد
                Image.asset(
                  Assets.imagesSendemail,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 32),
                
                // عنوان التأكيد
                const Text(
                  'تم إرسال رابط إعادة تعيين كلمة المرور',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                
                // تفاصيل إضافية
                const Text(
                  'تم إرسال رابط لتعيين كلمة المرور الجديدة إلى بريدك الإلكتروني. يرجى التحقق من صندوق الوارد الخاص بك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
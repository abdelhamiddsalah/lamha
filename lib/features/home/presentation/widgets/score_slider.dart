import 'package:flutter/material.dart';
import 'package:lamha/core/styles/app_colors.dart';
import 'package:lamha/core/styles/text_styles.dart';

class ScoreSlider extends StatefulWidget {
  const ScoreSlider({super.key});

  @override
  State<ScoreSlider> createState() => _ScoreState();
}

class _ScoreState extends State<ScoreSlider> {
  double _value = 70;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0), // بدون مؤشر
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),   // بدون تأثير عند الضغط
            trackHeight: 6,
            activeTrackColor: AppColors.mainColor,
            inactiveTrackColor: Colors.grey.shade300,
          ),
          child: Slider(
            value: _value,
            min: 0,
            max: 100,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          ),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "1/3 متمكل ",
              style: TextStyles.text21.copyWith (color: Colors.grey.shade600 ),
            ),
           
             Text(
          "Score: ${_value.toInt()}",
              style: TextStyles.text21.copyWith (color: Colors.grey.shade600 ,),
        ),
          ],
        )
      ],
    );
  }
}

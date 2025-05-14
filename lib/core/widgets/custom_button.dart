import 'package:flutter/material.dart';
import 'package:lamha/core/styles/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, 
    required this.color, 
    required this.width, 
    required this.text, 
    this.border,
    required this.textcolor
  });

  final Color color;
  final double width;
  final String text;
  final BoxBorder? border;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 55,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: border ?? Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          text, 
          style: TextStyles.titleButton, 
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
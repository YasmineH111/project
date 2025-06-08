import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextButtun extends StatelessWidget {
  const CustomTextButtun({
    super.key,
    required this.text,
    this.onPressed,
  });
  final String text;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTextStyles.title18White,
        ));
  }
}

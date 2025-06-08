import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.title20KBlueColor,
        ),
      ],
    );
  }
}

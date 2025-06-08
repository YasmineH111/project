import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title,
    this.onPressed,
  });
  final String title;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            backgroundColor: AppColors.kBlueColor),
        onPressed: onPressed,
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.title24KGreyColor,
          ),
        ));
  }
}

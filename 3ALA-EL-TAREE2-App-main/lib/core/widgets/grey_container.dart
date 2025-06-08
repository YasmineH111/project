import 'package:cabify/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GreyContainer extends StatelessWidget {
  const GreyContainer({
    super.key,
    required this.title,
    required this.style,
  });
  final String title;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      decoration: BoxDecoration(
          color: AppColors.kGreyColor,
          borderRadius: BorderRadius.circular(16.r)),
      child: Text(
        title,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}

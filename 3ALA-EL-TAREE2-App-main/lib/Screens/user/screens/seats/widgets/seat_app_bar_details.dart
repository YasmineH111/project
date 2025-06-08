import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeatAppBarDetails extends StatelessWidget {
  const SeatAppBarDetails({
    super.key,
    required this.title,
    required this.color,
  });
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.0.w),
      child: Row(
        spacing: 5.w,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          Text(
            title,
            style: AppTextStyles.title16GreyColor,
          )
        ],
      ),
    );
  }
}

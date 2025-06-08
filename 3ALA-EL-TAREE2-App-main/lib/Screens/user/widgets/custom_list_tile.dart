import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: const BorderSide(
            color: AppColors.kBlueColor,
            width: 3,
            strokeAlign: BorderSide.strokeAlignCenter),
      ),
      leading: Icon(
        icon,
        color: AppColors.kBlueColor,
        size: 30,
      ),
      title: Text(title, style: AppTextStyles.title24KBlueColor),
    );
  }
}

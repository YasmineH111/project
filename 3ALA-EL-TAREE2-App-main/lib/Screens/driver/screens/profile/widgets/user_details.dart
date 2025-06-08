import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
    required this.fieldName,
    required this.fieldLabel,
    required this.controller,
    required this.editField,
    this.isPassword = false,
  });
  final bool isPassword;
  final String fieldName;
  final String fieldLabel;
  final TextEditingController controller;
  final bool editField;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5.h,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            fieldName,
            style: AppTextStyles.title20KBlueColor,
          ),
        ),
        CustomTextField(
          label: fieldLabel,
          textAlignCenter: false,
          isPassword: isPassword,
          style:
              AppTextStyles.title16Grey.copyWith(fontWeight: FontWeight.w500),
          controller: controller,
          enableEdit: editField,
        ),
      ],
    );
  }
}

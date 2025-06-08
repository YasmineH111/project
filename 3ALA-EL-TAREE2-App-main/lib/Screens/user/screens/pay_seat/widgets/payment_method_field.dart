import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodField extends StatelessWidget {
  const PaymentMethodField({
    super.key,
    required this.title,
    required this.label,
    this.maxLenght,
    this.controller,
  });
  final String title;
  final String label;
  final int? maxLenght;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        Text(
          title,
          style: AppTextStyles.title20KBlueColor,
        ),
        CustomTextField(
          label: label,
          textAlignCenter: false,
          style: AppTextStyles.title16Grey,
          maxLength: maxLenght,
          controller: controller,
        )
      ],
    );
  }
}

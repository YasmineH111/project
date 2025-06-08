import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentListTile extends StatelessWidget {
  const PaymentListTile({
    super.key,
    required this.paymentTitle,
    this.fontSize,
  });

  final String paymentTitle;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20.r,
        backgroundColor: AppColors.kBlueColor,
        child: const Icon(
          Icons.money,
          color: Colors.white,
        ),
      ),
      title: Text(
        paymentTitle,
        style: AppTextStyles.title24KBlueColor.copyWith(fontSize: fontSize),
      ),
    );
  }
}

import 'package:cabify/Screens/user/screens/pay_seat/widgets/payment_list_tile.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({
    super.key,
    required this.paymentTitle,
    required this.label,
    this.controller,
    required this.maxLenght,
    this.maxLength,
  });
  final String paymentTitle;
  final String label;
  final TextEditingController? controller;
  final int maxLenght;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentListTile(paymentTitle: paymentTitle),
        CustomTextField(
          maxLength: maxLenght,
          controller: controller,
          label: label,
          style: AppTextStyles.title16Grey,
          textAlignCenter: false,
        ),
      ],
    );
  }
}

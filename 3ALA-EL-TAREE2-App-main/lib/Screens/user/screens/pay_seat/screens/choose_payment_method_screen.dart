import 'package:cabify/Screens/user/screens/pay_seat/widgets/choose_payment_method_screen_body.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class ChoosePaymentMethodScreen extends StatelessWidget {
  const ChoosePaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.kBlueColor,
      body: ChoosePaymentMethodScreenBody(),
    );
  }
}

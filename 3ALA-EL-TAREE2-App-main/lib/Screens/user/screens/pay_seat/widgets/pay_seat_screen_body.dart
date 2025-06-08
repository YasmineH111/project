import 'package:cabify/core/assets/images/app_images.dart';
import 'package:cabify/core/routes/route_names.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaySeatScreenTicket extends StatelessWidget {
  const PaySeatScreenTicket({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Buy a ticket",
            style: AppTextStyles.title48KBlueColor,
          ),
          Column(
            spacing: 15.h,
            children: [
              Image.asset(AppImages.ticketImage),
              const Text(
                "Use a promo code",
                style: AppTextStyles.title24KBlueColor,
              )
            ],
          ),
          CustomElevatedButton(
            title: "Continue",
            onPressed: () {
              Navigator.pushNamed(
                  context, RouteNames.choosePaymentMethodScreen);
            },
          )
        ],
      ),
    );
  }
}

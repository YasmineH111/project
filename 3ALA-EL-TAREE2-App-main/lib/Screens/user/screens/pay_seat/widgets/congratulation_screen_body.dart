import 'package:cabify/core/assets/images/app_images.dart';
import 'package:cabify/core/routes/route_names.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CongratulationScreenBody extends StatelessWidget {
  const CongratulationScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.paymentDoneImage),
          const Text(
            "Congratulations",
            style: AppTextStyles.title36KBlueColor,
          ),
          const Text(
            "Congratulations on a successful  Online payment ",
            style: AppTextStyles.title20KBlueColor,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 200.h),
          CustomElevatedButton(
            title: "your ticket",
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.myTicketScreen);
            },
          )
        ],
      ),
    );
  }
}

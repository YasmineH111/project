import 'package:cabify/Screens/user/screens/pay_seat/widgets/my_ticket_widget.dart';
import 'package:cabify/core/assets/images/app_images.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/routes/route_names.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTicketScreenBody extends StatelessWidget {
  const MyTicketScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                      color: AppColors.kDarkBlueColor,
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Image.asset(AppImages.seatTicketImage)),
              title: const Text(
                'Your Ticket',
                style: AppTextStyles.title36KBlueColor,
              ),
            ),
            Image.asset(AppImages.congratulationImage),
            const MyTicketWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: CustomElevatedButton(
                  title: "Back to Home",
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteNames.findTripScreen, (_) => false);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

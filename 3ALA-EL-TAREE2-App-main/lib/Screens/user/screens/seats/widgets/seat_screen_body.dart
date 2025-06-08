import 'package:cabify/Screens/user/screens/find_trip/provider/find_trip_provider.dart';
import 'package:cabify/Screens/user/screens/seats/widgets/seat_number_details.dart';
import 'package:cabify/Screens/user/widgets/custom_app_bar.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SeatsScreenBody extends StatelessWidget {
  const SeatsScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FindTripProvider>(builder: (context, provider, child) {
      return SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  color: AppColors.kBlueColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  height: 350.h,
                  child: CustomAppBar(
                    title: "Select your seat!",
                    from: provider.selectedFromDestination!.name,
                    to: provider.selectedToDestination!.name,
                    time: provider.time,
                    child: CustomTextButtun(
                      text: "Next",
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.kGreyMeduimColor,
                  ),
                )
              ],
            ),
            SeatNumberDetails(
              tripModel: provider.trip!,
              to: provider.selectedToDestination!.name,
            ),
          ],
        ),
      );
    });
  }
}

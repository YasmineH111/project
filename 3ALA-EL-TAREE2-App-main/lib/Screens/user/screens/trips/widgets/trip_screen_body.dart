import 'package:cabify/Screens/user/screens/find_trip/provider/find_trip_provider.dart';
import 'package:cabify/Screens/user/screens/trips/widgets/custom_trip_card_details.dart';
import 'package:cabify/Screens/user/widgets/custom_app_bar.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TripScreenBody extends StatelessWidget {
  const TripScreenBody({
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
                    title: "Select your bus!",
                    from: provider.selectedFromDestination!.name,
                    to: provider.selectedToDestination!.name,
                    time: provider.time,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 290.h,
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 310.h,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  itemCount: provider.tripList.length,
                  itemBuilder: (context, index) {
                    return CustomTripCardDetails(
                      tripModel: provider.tripList[index],
                      onTap: () {
                        provider.selectTrip(index);
                        Navigator.pushNamed(context, RouteNames.seatsScreen);
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

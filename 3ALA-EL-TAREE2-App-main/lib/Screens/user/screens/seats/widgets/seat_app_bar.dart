import 'package:cabify/Screens/user/screens/seats/widgets/seat_app_bar_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeatAppBar extends StatelessWidget {
  const SeatAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            SeatAppBarDetails(
              color: Colors.blue,
              title: "Booked (male)",
            ),
            SeatAppBarDetails(
              color: Colors.grey,
              title: "Available",
            ),
            SeatAppBarDetails(
              color: Colors.pink,
              title: "Booked (female)",
            ),
          ],
        ));
  }
}

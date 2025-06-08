import 'package:cabify/Screens/user/screens/seats/widgets/seat_app_bar.dart';
import 'package:cabify/Screens/user/screens/seats/widgets/seat_type.dart';
import 'package:cabify/model/my_trips_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverSeatsScreenBody extends StatelessWidget {
  const DriverSeatsScreenBody({
    super.key,
    required this.tripModel,
  });

  final MyTripModel tripModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SeatAppBar(),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Colors.white,
            ),
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              itemCount: 15,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 48.w,
                mainAxisSpacing: 48.h,
              ),
              itemBuilder: (context, index) {
                return SeatType(
                  gender: tripModel.seats[index].genderPreference,
                  isBooked: tripModel.seats[index].isAvailable,
                  seatId: tripModel.seats[index].seatNumber,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

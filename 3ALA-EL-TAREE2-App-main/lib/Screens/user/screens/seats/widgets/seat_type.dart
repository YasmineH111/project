import 'package:cabify/core/assets/images/app_images.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeatType extends StatelessWidget {
  const SeatType({
    super.key,
    required this.isBooked,
    required this.seatId,
    this.onTap,
    required this.gender,
  });
  final bool isBooked;
  final int seatId;
  final Function()? onTap;
  final String gender;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: seatId == 1
              ? Colors.white
              : !isBooked
                  ? gender == "Male"
                      ? Colors.blue
                      : Colors.pink
                  : AppColors.kGreyMeduimColor,
        ),
        child: seatId == 1
            ? Center(
                child: Image.asset(
                  AppImages.wheelImage,
                  height: 50.h,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}

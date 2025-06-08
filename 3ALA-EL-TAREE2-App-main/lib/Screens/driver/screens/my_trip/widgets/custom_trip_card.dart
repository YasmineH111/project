import 'package:cabify/core/assets/images/app_images.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTripsCard extends StatelessWidget {
  const CustomTripsCard({
    super.key,
    required this.price,
    required this.tripNumber,
    this.image,
    required this.totalSeats,
    required this.bookedSeats,
    this.onTap,
  });
  final String price;
  final String tripNumber;
  final String totalSeats;
  final String bookedSeats;
  final String? image;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.kBlueColor),
            borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            children: [
              Image.asset(image ?? AppImages.busImage),
              Text(
                "trip Number $tripNumber",
                style: AppTextStyles.title20KBlueColor,
              ),
              Text(
                "seat price $price",
                style: AppTextStyles.title20KBlueColor,
              ),
              Text(
                "Total Seats $totalSeats",
                style: AppTextStyles.title20KBlueColor,
              ),
              Text(
                "Booked seats $bookedSeats",
                style: AppTextStyles.title20KBlueColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

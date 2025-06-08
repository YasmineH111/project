import 'package:cabify/Screens/user/screens/find_trip/provider/find_trip_provider.dart';
import 'package:cabify/Screens/user/widgets/row_details.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/model/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CustomTripCardDetails extends StatelessWidget {
  const CustomTripCardDetails({
    super.key,
    this.onTap,
    required this.tripModel,
  });
  final Function()? onTap;
  final TripModel tripModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Consumer<FindTripProvider>(
        builder: (context, provider, child) => GestureDetector(
          onTap: onTap,
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                spacing: 10.h,
                children: [
                  RowDetails(
                    firstChild: Text(
                      provider.selectedFromDestination?.name ?? "",
                      style: AppTextStyles.title18KBlueColor,
                    ),
                    secondChild: Text(
                      "${tripModel.price} EGP",
                      style: AppTextStyles.title18KBlueColor,
                    ),
                  ),
                  RowDetails(
                      firstChild: Text(
                        "Started At : ${(DateFormat.jm()).format(tripModel.date!)}",
                        style: AppTextStyles.title16KBlueColor,
                      ),
                      secondChild: const Text("")),
                  RowDetails(
                      firstChild: Text(
                        "${tripModel.seatsTotal! - tripModel.seatsBooked!} Seats Left",
                        style: AppTextStyles.title18KBlueColor,
                      ),
                      secondChild: const Text("")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

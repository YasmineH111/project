import 'package:cabify/Screens/user/screens/find_trip/provider/find_trip_provider.dart';
import 'package:cabify/Screens/user/widgets/row_details.dart';
import 'package:cabify/core/cache/cache_helper.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyTicketWidget extends StatelessWidget {
  const MyTicketWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      height: MediaQuery.sizeOf(context).height * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.kBlueColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Consumer<FindTripProvider>(builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(provider.selectedFromDestination?.name ?? "",
                    style: AppTextStyles.title20White),
                Icon(
                  Icons.change_circle,
                  color: Colors.white,
                ),
                Text(provider.selectedToDestination?.name ?? "",
                    style: AppTextStyles.title20White),
              ],
            ),
            Center(
              child: Text(
                DateFormat.yMMMMEEEEd().format(provider.time),
                style: AppTextStyles.title16White,
              ),
            ),
            Text(
              "Stated At : ${DateFormat.jm().format(provider.time)}",
              style: AppTextStyles.title20White,
            ),
            RowDetails(
              firstChild: Text(
                "${provider.selectedFromDestination?.name} Travel",
                style: AppTextStyles.title20White,
              ),
              secondChild: Text(
                "From",
                style: AppTextStyles.title18White,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${provider.trip!.price} EGP",
                  style: AppTextStyles.title20White,
                )
              ],
            ),
            const Text(
              "1 Seat",
              style: AppTextStyles.title20White,
            ),
            Text(
              "Name : ${locator<CacheHelper>().getData(key: "name") ?? ""}",
              style: AppTextStyles.title20White,
            ),
            Text(
              "Mobile : ${locator<CacheHelper>().getData(key: "phone") ?? ""}",
              style: AppTextStyles.title20White,
            )
          ],
        );
      }),
    );
  }
}

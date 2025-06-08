import 'package:cabify/Screens/user/widgets/row_details.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CustomSeatCardDetails extends StatelessWidget {
  const CustomSeatCardDetails({
    super.key,
    required this.to,
    required this.startedAt,
    required this.price,
  });
  final String to;
  final DateTime startedAt;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              RowDetails(
                firstChild: Text(
                  "${DateFormat.yMMMMEEEEd().format(startedAt)}",
                  style: AppTextStyles.title18KBlueColor,
                ),
                secondChild:
                    Text("From", style: AppTextStyles.title18KBlueColor),
              ),
              Row(
                children: [
                  Text(
                    "Started At : ${DateFormat.jm().format(startedAt)}",
                    style: AppTextStyles.title18KBlueColor,
                  )
                ],
              ),
              RowDetails(
                  firstChild: Text(to, style: AppTextStyles.title18KBlueColor),
                  secondChild: Text(
                    price,
                    style: AppTextStyles.title18KBlueColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

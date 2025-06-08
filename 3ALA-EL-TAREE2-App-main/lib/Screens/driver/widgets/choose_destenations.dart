import 'package:cabify/Screens/driver/widgets/custom_search_delegate.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseDestinations extends StatelessWidget {
  const ChooseDestinations({
    super.key,
    required this.boardingFrom,
    required this.boardingTo,
    required this.userType,
  });
  final TextEditingController boardingFrom;
  final TextEditingController boardingTo;
  final String userType;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: "boarding from",
              controller: boardingFrom,
              onTap: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    searchAbout: "from",
                    userType: userType,
                  ),
                );
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomTextField(
              label: "boarding to",
              controller: boardingTo,
              onTap: () {
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                        searchAbout: "to", userType: userType));
              },
            )
          ],
        ),
        Positioned(
          right: 0,
          height: 130.h,
          child: const Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.kBlueColor,
                child: Icon(
                  Icons.loop,
                  color: AppColors.kGreyColor,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

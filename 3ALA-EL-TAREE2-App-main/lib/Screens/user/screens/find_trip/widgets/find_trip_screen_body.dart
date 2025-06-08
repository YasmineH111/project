import 'package:cabify/Screens/user/screens/find_trip/widgets/find_trip_screen_form.dart';
import 'package:cabify/core/assets/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FindTripScreenBody extends StatelessWidget {
  const FindTripScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Image.asset(
            AppImages.busImage,
            height: 180.h,
          ),
          const FindTripScreenForm()
        ],
      ),
    );
  }
}

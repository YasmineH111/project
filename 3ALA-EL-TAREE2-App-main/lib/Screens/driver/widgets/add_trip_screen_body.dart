// ignore_for_file: use_build_context_synchronously
import 'package:cabify/Screens/driver/widgets/add_trip_form.dart';
import 'package:cabify/core/widgets/custom_app_bar.dart';
import 'package:cabify/core/widgets/custom_gradient_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTripScreenBody extends StatelessWidget {
  const AddTripScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomGradientBody(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                child: const CustomAppBar(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                margin: EdgeInsets.only(top: 5.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: const AddTripForm(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

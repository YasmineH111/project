import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotAvilableSeat extends StatelessWidget {
  const NotAvilableSeat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 200.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "This seat is not available",
                style: AppTextStyles.title24KBlueColor,
              ),
              CustomElevatedButton(
                title: "Close",
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

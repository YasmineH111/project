import 'package:cabify/Screens/driver/widgets/custom_icon_button.dart';
import 'package:cabify/core/assets/images/app_images.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/routes/route_names.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_auth_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerAppBar extends StatelessWidget {
  const DrawerAppBar({
    super.key,
    required this.onPressed,
  });

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Center(
                    child: CustomIconButton(
                      icon: Icons.close,
                      color: AppColors.kBlueColor,
                      size: 25,
                      onPressed: onPressed,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 20.w,
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    AppImages.profileImage,
                  ),
                ),
                const Text(
                  "Profile",
                  style: AppTextStyles.title24White,
                )
              ],
            ),
            CustomElevatedButton(
              title: "Show Profile",
              route: RouteNames.profileScreen,
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.profileScreen);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:cabify/Screens/user/widgets/custom_list_tile.dart';
import 'package:cabify/core/cache/cache_helper.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:cabify/core/routes/route_names.dart';
import 'package:cabify/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          spacing: 10.h,
          children: [
            CustomListTile(
              icon: Icons.location_on,
              title: "Map",
              onTap: () => Navigator.pushNamed(context, RouteNames.mapScreen),
            ),
            CustomListTile(
              icon: Icons.info,
              title: "About",
              onTap: () => Navigator.pushNamed(context, RouteNames.aboutScreen),
            ),
            CustomListTile(
              icon: Icons.info,
              title: "FeedBack",
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.feedbackScreen),
            ),
            CustomListTile(
              icon: Icons.chair,
              title: "My Seats",
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.mySeatScreen),
            ),
            const Spacer(),
            CustomElevatedButton(
              title: "Log out",
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('token', '');
                await prefs.setString('passengerId', '');
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.onBoard, (route) => false);
              },
            )
          ],
        ),
      ),
    ));
  }
}

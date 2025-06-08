// ignore_for_file: use_build_context_synchronously
import 'package:cabify/Screens/driver/screens/my_trip/provider/my_trip_provider.dart';
import 'package:cabify/Screens/driver/screens/my_trip/widgets/my_trips_screen_body.dart';
import 'package:cabify/Screens/driver/widgets/custom_icon_button.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyTripsScreen extends StatelessWidget {
  const MyTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kBlueColor,
        leading: CustomIconButton(
          icon: Icons.arrow_back_ios_new_outlined,
          color: Colors.white,
          size: 25.w,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Trips",
          style: AppTextStyles.title24White,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => locator<MyTripsProvider>(),
        child: const MyTripsScreenBody(),
      ),
    );
  }
}

import 'package:cabify/Screens/user/screens/find_trip/provider/main_provider.dart';
import 'package:cabify/Screens/user/screens/find_trip/widgets/find_trip_screen_body.dart';
import 'package:cabify/Screens/user/widgets/custom_drawer.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindTripScreen extends StatelessWidget {
  const FindTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<MainProvider>(),
      child: Consumer<MainProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            key: provider.key,
            backgroundColor: AppColors.kBlueColor,
            body: const FindTripScreenBody(),
            drawer: CustomDrawer(
              onPressed: () {
                provider.closeDrawer();
              },
            ),
            floatingActionButton: CustomFloatingActionButton(
              onPressed: () {
                provider.openDrawer();
              },
            ),
          );
        },
      ),
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    this.onPressed,
  });
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      shape: const CircleBorder(
        side: BorderSide(color: AppColors.kGreyMeduimColor, width: 5),
      ),
      backgroundColor: AppColors.kBlueColor,
      child: const Icon(Icons.menu),
    );
  }
}

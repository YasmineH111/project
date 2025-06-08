import 'package:cabify/Screens/driver/widgets/add_trip_screen_body.dart';
import 'package:cabify/Screens/driver/widgets/custom_drawer.dart';
import 'package:cabify/Screens/user/screens/find_trip/provider/main_provider.dart';
import 'package:cabify/Screens/user/screens/find_trip/screens/find_trip_screen.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTripScreen extends StatelessWidget {
  const AddTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (context) => locator<MainProvider>(),
      child: Consumer<MainProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            key: provider.key,
            backgroundColor: AppColors.kBlueColor,
            body: const AddTripScreenBody(),
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
    ));
  }
}

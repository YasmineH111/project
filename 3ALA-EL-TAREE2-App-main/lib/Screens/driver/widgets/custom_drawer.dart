import 'package:cabify/Screens/driver/widgets/drawer_body.dart';
import 'package:cabify/Screens/driver/widgets/drawer_header.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, this.onPressed});
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            color: AppColors.kBlueColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DrawerAppBar(onPressed: onPressed),
                const DrawerBody()
              ],
            ),
          )
        ],
      ),
    );
  }
}

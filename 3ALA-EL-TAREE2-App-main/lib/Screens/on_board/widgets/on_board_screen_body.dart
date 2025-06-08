import 'package:cabify/Screens/on_board/widgets/driver_or_user.dart';
import 'package:cabify/core/assets/images/app_images.dart';
import 'package:flutter/material.dart';

class OnBoardScreenBody extends StatelessWidget {
  const OnBoardScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(AppImages.logoImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppImages.busImage,
            height: 400,
          ),
          const DriverOrUser(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

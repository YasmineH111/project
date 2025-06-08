import 'package:cabify/core/assets/images/app_images.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomGradientBody extends StatelessWidget {
  const CustomGradientBody({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(62, 110, 135, 0.75),
            AppColors.kBlueColor,
          ],
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          opacity: 0.2,
          image: AssetImage(
            AppImages.logoImage,
          ),
        ),
      ),
      child: child,
    );
  }
}

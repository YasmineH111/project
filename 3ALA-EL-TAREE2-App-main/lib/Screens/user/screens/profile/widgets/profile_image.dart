import 'dart:io';

import 'package:cabify/Screens/driver/widgets/custom_icon_button.dart';
import 'package:cabify/core/assets/images/app_images.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    this.onPressed,
    this.selectedImage,
  });
  final Function()? onPressed;
  final File? selectedImage;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 80.r,
          backgroundImage: selectedImage != null
              ? FileImage(selectedImage!)
              : AssetImage(
                  AppImages.profileImage,
                ),
        ),
        Positioned(
          bottom: -5,
          right: -5,
          child: CircleAvatar(
            radius: 25.r,
            backgroundColor: AppColors.kBlueColor,
            child: Center(
              child: CustomIconButton(
                size: 25,
                icon: Icons.upload,
                color: Colors.white,
                onPressed: onPressed,
              ),
            ),
          ),
        )
      ],
    );
  }
}

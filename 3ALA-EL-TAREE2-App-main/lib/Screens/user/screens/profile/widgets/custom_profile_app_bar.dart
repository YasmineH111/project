import 'package:cabify/Screens/driver/widgets/custom_icon_button.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomProfileAppBar extends StatelessWidget {
  const CustomProfileAppBar({
    super.key,
    this.onPressed,
    required this.enableEdit,
  });
  final Function()? onPressed;
  final bool enableEdit;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Personal Data",
          style: AppTextStyles.title36KBlueColor,
        ),
        CustomIconButton(
          icon: enableEdit ? Icons.lock : Icons.edit,
          color: AppColors.kBlueColor,
          onPressed: onPressed,
        )
      ],
    );
  }
}

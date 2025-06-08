import 'package:cabify/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size,
  });
  final IconData icon;
  final Function()? onPressed;
  final Color? color;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: size ?? 36,
        color: color ?? AppColors.kBlueColor,
      ),
    );
  }
}

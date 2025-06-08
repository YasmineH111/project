import 'package:cabify/Screens/driver/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({
    super.key,
    this.child,
    this.onPressed,
  });
  final Widget? child;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 24,
          onPressed: () => Navigator.pop(context),
        ),
        child ??
            CustomIconButton(
              icon: Icons.filter_alt_outlined,
              color: Colors.white,
              size: 25,
              onPressed: onPressed,
            ),
      ],
    );
  }
}

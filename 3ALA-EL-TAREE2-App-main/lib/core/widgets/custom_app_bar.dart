import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.menu,
          size: 30,
        ),
        Column(
          children: [
            Icon(
              Icons.directions_bus_filled_outlined,
              color: Colors.white,
              size: 70,
            ),
            Text(
              "3ALA EL-TAREE2",
              style: AppTextStyles.title26Black,
            ),
            Text(
              "Travel easily",
              style: AppTextStyles.title20White,
            )
          ],
        ),
        CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 30,
            ))
      ],
    );
  }
}

import 'package:cabify/Screens/user/widgets/app_bar_icon.dart';
import 'package:cabify/Screens/user/widgets/destenations.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.child,
    required this.title,
    this.time,
    required this.from,
    required this.to,
  });
  final Widget? child;
  final String title;
  final DateTime? time;
  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.h,
      children: [
        AppBarIcon(
          child: child,
        ),
        Text(
          title,
          style: AppTextStyles.title24White,
        ),
        Destenations(
          from: from,
          to: to,
        ),
        Text(
          DateFormat.yMMMMEEEEd().format(time ?? DateTime.now()),
          style: AppTextStyles.title18White,
        )
      ],
    );
  }
}

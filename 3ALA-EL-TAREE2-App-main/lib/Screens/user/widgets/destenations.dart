import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Destenations extends StatelessWidget {
  const Destenations({
    super.key,
    required this.from,
    required this.to,
  });
  final String from, to;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 170.w,
          child: Text(
            from,
            style: AppTextStyles.title20White,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        const Icon(
          Icons.change_circle_outlined,
          color: Colors.white,
          size: 30,
        ),
        SizedBox(
          width: 170.w,
          child: Text(
            to,
            style: AppTextStyles.title20White,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

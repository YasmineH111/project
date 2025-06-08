import 'package:cabify/Screens/driver/screens/feed_back/widgets/feed_back_screen_body.dart';
import 'package:cabify/Screens/driver/widgets/custom_icon_button.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class DriverFeedBackScreen extends StatelessWidget {
  const DriverFeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBlueColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: CustomIconButton(
          icon: Icons.arrow_back,
          color: Colors.white,
          size: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("FeedBack", style: AppTextStyles.title24White),
        centerTitle: true,
      ),
      body: const DriverFeedBackScreenBody(),
    );
  }
}

import 'package:cabify/Screens/user/screens/about/widgets/about_screen_body.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: AppTextStyles.title18KBlueColor,
        ),
      ),
      body: const AboutScreenBody(),
    );
  }
}

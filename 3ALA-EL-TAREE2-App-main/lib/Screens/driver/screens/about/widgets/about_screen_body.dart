import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutScreenBody extends StatelessWidget {
  const AboutScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
      child: const Text(
        "Our bus Driver App is the nucleus of our transportation network, enabling passengers to effortlessly book trips and access vital details. Tailored for driver convenience, the app allows seamless input of trip specifics, ensuring smooth experiences for both drivers and passengers. Transparency is prioritized, with comprehensive trip information available, including estimated fares and distances, empowering informed decision-making. Safety features such as real-time navigation and emergency assistance provide peace of mind. Additionally, the app fosters a community among drivers, offering resources and feedback channels for continuous support and improvement. Join our network to experience the reliability, efficiency, and security our Driver Application offers, revolutionizing transportation one trip at a time. With our app, drivers can navigate confidently, knowing they have all the necessary tools at their fingertips to deliver exceptional service while ensuring passenger safety.",
        style: AppTextStyles.title16KBlueColor,
      ),
    );
  }
}

import 'package:cabify/Screens/user/screens/feed_back/provider/feed_back_provider.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_elevated_button.dart';
import 'package:cabify/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedBackAndRating extends StatelessWidget {
  const FeedBackAndRating({
    super.key,
    required this.provider,
  });
  final FeedBackProvider provider;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 30.h,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "How is your trip?",
            style: AppTextStyles.title24KBlueColor,
          ),
          const Text(
            "Your feedback will help improve driving experience",
            style: AppTextStyles.title18KBlueColor,
            textAlign: TextAlign.center,
          ),
          Column(
            spacing: 30.h,
            children: [
              RatingBar.builder(
                allowHalfRating: true,
                itemBuilder: (context, index) => const Icon(
                  Icons.star_rate_rounded,
                  color: AppColors.kBlueColor,
                ),
                initialRating: provider.rating,
                unratedColor: AppColors.kGreyMeduimColor,
                onRatingUpdate: (rating) {
                  provider.rating = rating;
                },
              ),
              CustomTextField(
                label: "Additional Comments",
                manLines: 5,
                fillColor: AppColors.kGreyColor,
                textAlignCenter: false,
                style: AppTextStyles.title16Grey,
                controller: provider.feedBackController,
                enableValodator: false,
              ),
            ],
          ),
          CustomElevatedButton(
            title: "Submit",
            onPressed: () {
              provider.updateFeedBack(context: context);
            },
          )
        ],
      ),
    );
  }
}

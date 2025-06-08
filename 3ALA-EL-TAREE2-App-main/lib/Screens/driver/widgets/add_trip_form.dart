import 'package:cabify/Screens/driver/provider/add_trip_provider.dart';
import 'package:cabify/Screens/driver/widgets/choose_destenations.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_elevated_button.dart';
import 'package:cabify/core/widgets/custom_text_field.dart';
import 'package:cabify/core/widgets/grey_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddTripForm extends StatelessWidget {
  const AddTripForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTripProvider>(
      builder: (context, provider, child) {
        return Form(
          key: provider.formKey,
          child: Column(
            spacing: 10.h,
            children: [
              const Text(
                "Hey!\nwhere are your trip will go",
                style: AppTextStyles.title20KBlueColor,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 7.h,
              ),
              const GreyContainer(
                  title: "Stop Points", style: AppTextStyles.title24KBlueColor),
              ChooseDestinations(
                userType: "Driver",
                boardingFrom: provider.fromDestinationController,
                boardingTo: provider.toDestinationController,
              ),
              SizedBox(
                height: 10.h,
              ),
              GreyContainer(
                title: provider.timeAdded ? provider.formatDate : "Date",
                style: AppTextStyles.title24KBlueColor,
              ),
              Row(
                spacing: 10.w,
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      title: "Select Date & time",
                      onPressed: () {
                        provider.selectDateAndTime(context: context);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 7.h,
              ),
              const GreyContainer(
                title: "Trip Price",
                style: AppTextStyles.title24KBlueColor,
              ),
              CustomTextField(
                label: "amount of many",
                style: AppTextStyles.title16Grey,
                controller: provider.tripPriceController,
              ),
              provider.tripAdedd
                  ? const CircularProgressIndicator()
                  : CustomElevatedButton(
                      title: "Add Trip",
                      onPressed: () {
                        provider.addTrip(context: context);
                      },
                    )
            ],
          ),
        );
      },
    );
  }
}

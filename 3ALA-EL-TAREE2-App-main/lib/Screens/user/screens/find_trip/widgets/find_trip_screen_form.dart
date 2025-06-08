import 'package:cabify/Screens/driver/widgets/choose_destenations.dart';
import 'package:cabify/Screens/user/screens/find_trip/provider/find_trip_provider.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_elevated_button.dart';
import 'package:cabify/core/widgets/grey_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FindTripScreenForm extends StatelessWidget {
  const FindTripScreenForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<FindTripProvider>(builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.sizeOf(context).height - 180,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              color: Colors.white,
            ),
            child: Form(
              key: provider.formKey,
              child: Column(
                spacing: 20.h,
                children: [
                  const Text(
                    "Hay!\nwhere are you want to go",
                    style: AppTextStyles.title24KBlueColor,
                    textAlign: TextAlign.center,
                  ),
                  const GreyContainer(
                      title: "Stop Points",
                      style: AppTextStyles.title24KBlueColor),
                  ChooseDestinations(
                    boardingFrom: provider.fromDestinationController,
                    boardingTo: provider.toDestinationController,
                    userType: "User",
                  ),
                  GreyContainer(
                    title: provider.timeAdded ? provider.formatDate : "Date",
                    style: AppTextStyles.title24KBlueColor,
                  ),
                  Row(
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.w),
                    child: const Divider(
                      thickness: 3,
                    ),
                  ),
                  provider.loadTrips
                      ? const CircularProgressIndicator()
                      : CustomElevatedButton(
                          title: "Find Bus",
                          onPressed: () async {
                            await provider.searchForTrip(
                              context: context,
                            );
                          },
                        )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

import 'package:cabify/Screens/user/screens/seats/provider/seats_provider.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:cabify/core/routes/route_names.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserDetailsForBookSeat extends StatelessWidget {
  const UserDetailsForBookSeat({
    super.key,
    required this.seatNumber,
    required this.tripId,
  });

  final int tripId;
  final int seatNumber;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => locator<SeatsProvider>(),
      child: Consumer<SeatsProvider>(builder: (context, provider, child) {
        return Dialog(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Container(
              height: 300.h,
              color: AppColors.kGreyColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Do you want to Book seat number $seatNumber ?",
                    style: AppTextStyles.title24KBlueColor,
                    textAlign: TextAlign.center,
                  ),
                  DropdownButtonFormField<String>(
                    value: provider.selectedGender,
                    hint: const Text(
                      "Select Gender",
                      style: AppTextStyles.title16Grey,
                    ),
                    onChanged: (value) {
                      provider.selectedGender = value!;
                    },
                    items: ["Male", "Female"]
                        .map((gender) => DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.kGreyMeduimColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                  provider.seatBooked
                      ? const CircularProgressIndicator()
                      : CustomElevatedButton(
                          title: "Book Now",
                          onPressed: () async {
                            if (provider.selectedGender != null) {
                              await provider.bookSeat(
                                tripId: tripId.toString(),
                                seatNumber: seatNumber.toString(),
                                genderPreference: provider.selectedGender!,
                                context: context,
                              );
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteNames.paySeatScreen,
                                (route) => false,
                              );
                            } else {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select a gender'),
                                ),
                              );
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

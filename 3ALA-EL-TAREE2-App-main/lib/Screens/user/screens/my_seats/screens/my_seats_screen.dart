import 'package:cabify/Screens/driver/widgets/custom_icon_button.dart';
import 'package:cabify/Screens/user/screens/my_seats/provider/my_seats_provider.dart';
import 'package:cabify/core/assets/images/app_images.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MySeatsScreen extends StatelessWidget {
  const MySeatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kBlueColor,
        leading: CustomIconButton(
          icon: Icons.arrow_back_ios_new_outlined,
          color: Colors.white,
          size: 25.w,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Seats",
          style: AppTextStyles.title24White,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => locator<MySeatsProvider>(),
        child: Consumer<MySeatsProvider>(builder: (context, provider, child) {
          return FutureBuilder(
            future: provider.getMySeats(context: context),
            builder: (context, snapshot) {
              if (provider.seatsLoaded == false) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                itemCount: provider.seats.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return provider.seats.isEmpty
                      ? const Text("You dont have any seat")
                      : CustomSeatCard(
                          seatNumber:
                              provider.seats[index].seatNumber.toString(),
                          tripNumber: provider.seats[index].tripId.toString(),
                        );
                },
              );
            },
          );
        }),
      ),
    );
  }
}

class CustomSeatCard extends StatelessWidget {
  const CustomSeatCard({
    super.key,
    required this.seatNumber,
    required this.tripNumber,
  });
  final String seatNumber;
  final String tripNumber;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.kBlueColor),
          borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        children: [
          Image.asset(AppImages.seatImage),
          Text(
            "seat Number ${seatNumber}",
            style: AppTextStyles.title20KBlueColor,
          ),
          Text(
            "trip Number ${tripNumber}",
            style: AppTextStyles.title20KBlueColor,
          ),
        ],
      ),
    );
  }
}

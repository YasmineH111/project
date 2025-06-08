import 'package:cabify/Screens/driver/screens/my_trip/provider/my_trip_provider.dart';
import 'package:cabify/Screens/driver/screens/my_trip/screens/seats_screen.dart';
import 'package:cabify/Screens/driver/screens/my_trip/widgets/custom_trip_card.dart';
import 'package:cabify/core/assets/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyTripsScreenBody extends StatelessWidget {
  const MyTripsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyTripsProvider>(context, listen: false);
    
    Future.microtask(() => provider.getMySeats(context: context));
    
    return Consumer<MyTripsProvider>(
      builder: (context, provider, child) {
        if (provider.tripsLoaded == false) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.trips.isEmpty && provider.tripsLoaded) {
          return const Center(child: Text("You don't have any Trips"));
        }
        return GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
          itemCount: provider.trips.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            return CustomTripsCard(
              onTap: () async {
                provider.selectTrip(provider.trips[index]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DriverSeatsScreen(
                      tripModel: provider.trips[index],
                    ),
                  ),
                );
              },
              price: provider.trips[index].price.toString(),
              image: AppImages.myTripsImage,
              tripNumber: provider.trips[index].tripId.toString(),
              bookedSeats: provider.trips[index].seatsBooked.toString(),
              totalSeats: provider.trips[index].seatsTotal.toString(),
            );
          },
        );
      },
    );
  }
}

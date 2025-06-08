import 'package:cabify/Screens/driver/screens/my_trip/widgets/driver_seats_screen_body.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/model/my_trips_model.dart';
import 'package:flutter/material.dart';

class DriverSeatsScreen extends StatelessWidget {
  const DriverSeatsScreen({super.key, required this.tripModel});
  final MyTripModel tripModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColors.kBlueColor,
        title: const Text("Seats", style: AppTextStyles.title24White),
      ),
      body: DriverSeatsScreenBody(tripModel: tripModel),
    );
  }
}

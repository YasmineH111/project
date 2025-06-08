import 'package:cabify/Screens/user/screens/trips/widgets/trip_screen_body.dart';
import 'package:flutter/material.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      body: TripScreenBody(),
    );
  }
}

import 'package:cabify/Screens/user/screens/map/widgets/map_screen_body.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MapScreenBody(),
    );
  }
}

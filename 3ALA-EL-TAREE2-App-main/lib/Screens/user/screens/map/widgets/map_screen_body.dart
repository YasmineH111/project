import 'package:cabify/Screens/user/screens/map/provider/map_provider.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreenBody extends StatelessWidget {
  const MapScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(
      builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            provider.getLocation
                ? const Center(child: CircularProgressIndicator())
                : provider.currentPosition != null
                    ? Expanded(
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              provider.currentPosition!.latitude,
                              provider.currentPosition!.longitude,
                            ),
                            zoom: 12,
                          ),
                        ),
                      )
                    : const Text(
                        "Please enable location services to use this feature.",
                        style: AppTextStyles.title24KBlueColor,
                      ),
          ],
        );
      },
    );
  }
}

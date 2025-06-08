import 'package:cabify/Screens/driver/provider/add_trip_provider.dart';
import 'package:cabify/Screens/user/screens/map/widgets/map_screen_body.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SuggestionsBodyForDriver extends StatelessWidget {
  const SuggestionsBodyForDriver(
      {super.key, required this.query, required this.searchAbout});
  final String query;
  final String searchAbout;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MapScreenBody(),
        Consumer<AddTripProvider>(
          builder: (context, provider, child) {
            if (query.isEmpty) {
              return Center(
                child: provider.getLocation
                    ? const CircularProgressIndicator()
                    : TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.kBlueColor,
                        ),
                        onPressed: () async {
                          await provider.getCurrentLocation();
                        },
                        child: const Text(
                          'Select Current Location',
                          style: AppTextStyles.title24KGreyColor,
                        ),
                      ),
              );
            }
            return FutureBuilder(
              future: provider.fetchDestinationSuggestions(query: query),
              builder: (context, snapshot) {
                if (provider.isLoading == true) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return ListView.builder(
                    itemCount: provider.destinationSuggestions.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 8.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.kDarkBlueColor,
                            ),
                            borderRadius: BorderRadius.circular(16.r)),
                        child: ListTile(
                          onTap: () async {
                            searchAbout == "from"
                                ? await provider.setFromDestenation(
                                    provider.destinationSuggestions[index])
                                : await provider.setToDestenation(
                                    provider.destinationSuggestions[index],
                                  );
                            Navigator.pop(context);
                          },
                          leading: const Icon(
                            Icons.bus_alert_outlined,
                          ),
                          title: Text(
                            provider.destinationSuggestions[index]['name'],
                          ),
                        ),
                      );
                    });
              },
            );
          },
        ),
      ],
    );
  }
}

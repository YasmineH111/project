// ignore_for_file: use_build_context_synchronously

import 'package:cabify/Screens/user/screens/find_trip/provider/find_trip_provider.dart';
import 'package:cabify/Screens/user/screens/map/widgets/map_screen_body.dart';
import 'package:cabify/core/colors/app_colors.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SuggestionsBodyForUser extends StatelessWidget {
  const SuggestionsBodyForUser({
    super.key,
    required this.query,
    required this.searchAbout,
  });
  final String query;
  final String searchAbout;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MapScreenBody(),
        Consumer<FindTripProvider>(
          builder: (context, provider, child) {
            if (query.isEmpty) {
              return Center(
                child: provider.getLocation
                    ? const CircularProgressIndicator()
                    : TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.kDarkBlueColor,
                        ),
                        onPressed: () async {
                          await provider.getCurrentLocation(
                              destenationType: searchAbout);
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

import 'dart:developer';

import 'package:cabify/core/cache/cache_helper.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:cabify/core/services/api/api_consumer.dart';
import 'package:cabify/core/services/api/end_points.dart';
import 'package:cabify/model/seat_model.dart';
import 'package:flutter/material.dart';

class MySeatsProvider with ChangeNotifier {
  List<SeatModel> seats = [];
  final ApiConsumer apiConsumer;
  bool seatsLoaded = false;

  MySeatsProvider({required this.apiConsumer});

  Future<void> getMySeats({required BuildContext context}) async {
    if (!seatsLoaded) {
      try {
        final userId = await locator<CacheHelper>().getData(key: "userId");
        final data = await apiConsumer.get("${EndPoints.getMySeats}$userId");
        final List<SeatModel> loadedSeats = data
            .map<SeatModel>((element) => SeatModel.fromJson(element))
            .toList();

        seats = loadedSeats;
        log(seats.toString());

        seatsLoaded = true;
        notifyListeners();
      } catch (e) {
        log("Error fetching seats: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load seats: $e'),
          ),
        );
      }
    }
  }
}

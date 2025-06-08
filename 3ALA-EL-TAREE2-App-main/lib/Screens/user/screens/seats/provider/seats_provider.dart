// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cabify/core/cache/cache_helper.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:cabify/core/services/api/api_consumer.dart';
import 'package:cabify/core/services/api/end_points.dart';
import 'package:flutter/material.dart';

class SeatsProvider with ChangeNotifier {
  final ApiConsumer apiConsumer;
  String? selectedGender;
  bool seatBooked = false;
  SeatsProvider({required this.apiConsumer});
  bookSeat({
    required String tripId,
    required String seatNumber,
    required String genderPreference,
    required BuildContext context,
  }) async {
    seatBooked = true;
    notifyListeners();
    try {
      final data = await apiConsumer.post(
        EndPoints.bookSeatEndPoint,
        data: {
          "passengerId": await locator<CacheHelper>().getData(key: "userId"),
          "tripId": tripId,
          "genderPreference": selectedGender,
          "seatNumber": seatNumber,
          "bookingTime": DateTime.now().toIso8601String(),
        },
      );
      final bookingId = data["bookingId"];
      log(bookingId.toString());
      locator<CacheHelper>().saveData(key: "bookedId", value: bookingId);
    } catch (e) {
      log(e.toString());
    }
    seatBooked = false;
    notifyListeners();
  }
}

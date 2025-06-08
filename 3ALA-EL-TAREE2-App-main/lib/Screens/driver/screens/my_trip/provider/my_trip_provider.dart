import 'dart:developer';
import 'package:cabify/core/cache/cache_helper.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:cabify/core/services/api/api_consumer.dart';
import 'package:cabify/core/services/api/end_points.dart';
import 'package:cabify/model/my_trips_model.dart';
import 'package:flutter/material.dart';

class MyTripsProvider with ChangeNotifier {
  List<MyTripModel> trips = [];
  final ApiConsumer apiConsumer;
  bool tripsLoaded = false;

  MyTripsProvider({required this.apiConsumer});

  Future<void> getMySeats({required BuildContext context}) async {
    if (tripsLoaded) return;
    log("Loading trips...");
    try {
      final userId = await locator<CacheHelper>().getData(key: "id");
      log("User ID: $userId");

      final data = await apiConsumer.get("${EndPoints.getMyTrips}$userId");
      log("Data: $data");

      if (data is List) {
        trips = data
            .map((element) =>
                MyTripModel.fromJson(Map<String, dynamic>.from(element)))
            .toList();
      } else if (data is Map) {
        trips = [MyTripModel.fromJson(Map<String, dynamic>.from(data))];
      } else {
        throw Exception("Unexpected API response format");
      }

      tripsLoaded = true;
      notifyListeners();
    } catch (e) {
      log("Error getting trips: $e");

      if (e.toString().contains("No trips found")) {
        // طبيعي مافي رحلات، خلي trips فاضية بدون إظهار خطأ
        trips = [];
      } else {
        // خطأ حقيقي (مثلاً مشكلة نت)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("خطأ أثناء تحميل الرحلات: ${e.toString()}"),
          ),
        );
      }

      tripsLoaded = true; // مهم تخليه true عشان الشاشة ما تفضل تحمل
      notifyListeners();
    }
  }

  List<Seat>? mySeats;

  void selectTrip(MyTripModel trip) {
    mySeats = trip.seats;
    notifyListeners();
  }
}

// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cabify/core/routes/route_names.dart';
import 'package:cabify/core/services/api/api_consumer.dart';
import 'package:cabify/core/services/api/dio_consumer.dart';
import 'package:cabify/core/services/api/end_points.dart';
import 'package:cabify/model/destenation_model.dart';
import 'package:cabify/model/trip_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class FindTripProvider with ChangeNotifier {
  final fromDestinationController = TextEditingController();
  final toDestinationController = TextEditingController();
  DestenationModel? selectedFromDestination;
  DestenationModel? selectedToDestination;
  final formKey = GlobalKey<FormState>();
  final ApiConsumer consumer = DioConsumer(dio: Dio());
  Map<String, dynamic>? detenationLocation;
  List<TripModel> tripList = [];
  bool loadTrips = false;

  searchForTrip({required BuildContext context}) async {
    if (formKey.currentState!.validate()) {
      if (timeAdded) {
        tripList.clear();
        loadTrips = true;
        tripList.clear();
        notifyListeners();
        try {
          final response = await consumer.get(
            "${EndPoints.getTrip}/${selectedToDestination!.longitude}/${selectedToDestination!.latitude}/${selectedFromDestination!.longitude}/${selectedFromDestination!.latitude}",
          );
          for (var element in response) {
            tripList.add(TripModel.fromJson(element));
          }
          log(tripList.toString());
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.toString(),
              ),
            ),
          );
        }
        loadTrips = false;
        notifyListeners();
        Navigator.pushNamed(context, RouteNames.tripsScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please, Select Date & Time"),
          ),
        );
      }
    }
  }

  TripModel? trip;
  selectTrip(int index) {
    trip = tripList[index];
    notifyListeners();
  }

  ////////////////////////////
  bool getLocation = false;
  getCurrentLocation({required String destenationType}) async {
    getLocation = true;
    notifyListeners();
    bool serviceEnabled;
    LocationPermission permission;
    Position currentPosition;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    detenationLocation = {
      "lat": currentPosition.latitude,
      "lon": currentPosition.longitude,
      "name": "Current Location",
      "display_place": "Current Address"
    };
    destenationType == "from"
        ? setFromDestenation(detenationLocation!)
        : setToDestenation(detenationLocation!);
    getLocation = false;
    log(destenationType);
    log(detenationLocation.toString());
    notifyListeners();
    return currentPosition;
  }

  setFromDestenation(Map<String, dynamic> destination) {
    selectedFromDestination = DestenationModel.fromJson(destination);
    fromDestinationController.text = destination["name"];
    log("----------------------------------------------------------");
    log(selectedFromDestination!.toString());
    log("----------------------------------------------------------");
    notifyListeners();
  }

  setToDestenation(Map<String, dynamic> destination) {
    selectedToDestination = DestenationModel.fromJson(destination);
    toDestinationController.text = destination["name"];
    log("----------------------------------------------------------");
    log(selectedToDestination!.toString());
    log("----------------------------------------------------------");
    notifyListeners();
  }

///////////////////////////////////
  DateTime time = DateTime.now();
  bool timeAdded = false;
  String formatDate = "";
  selectDateAndTime({required BuildContext context}) async {
    DateTime? newDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: time);
    if (newDate == null) return;
    TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: time.hour, minute: time.minute));
    if (newTime == null) return;
    time = DateTime(
      newDate.year,
      newDate.month,
      newDate.day,
      newTime.hour,
      newTime.minute,
    );
    formatDate =
        "${DateFormat.yMMMMEEEEd().format(time)} - ${DateFormat.jm().format(time)}";
    log(formatDate.toString());
    timeAdded = true;
    notifyListeners();
  }

  //////////////////////////////
  List<Map<String, dynamic>> destinationSuggestions = [];
  Timer? _debounceTimer;
  final String _locationIqApiKey = 'pk.52c69844cb68f67a95da65d9fa143298';
  String lastQuery = '';
  bool isLoading = false;
  Future<void> fetchDestinationSuggestions({required String query}) async {
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel();
    }
    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      if (query.isNotEmpty) {
        if (query != lastQuery) {
          isLoading = true;
          lastQuery = query;
          try {
            final queryEncoded = Uri.encodeComponent(query);
            final url =
                'https://api.locationiq.com/v1/autocomplete?key=$_locationIqApiKey&q=$queryEncoded&limit=5&dedupe=1';
            final response = await http.get(Uri.parse(url));
            if (response.statusCode == 200) {
              final data = json.decode(response.body);
              log(json.encode(data));
              if (data is List) {
                destinationSuggestions = data
                    .where((item) =>
                        item['display_name'] != null &&
                        item['display_name'].isNotEmpty)
                    .map<Map<String, dynamic>>((item) => {
                          'name': item['display_name'] ?? 'No name available',
                          'lat': double.tryParse(item['lat'].toString()) ?? 0.0,
                          'lon': double.tryParse(item['lon'].toString()) ?? 0.0,
                        })
                    .toList();
              }
            } else {
              print('Failed with status code: ${response.statusCode}');
            }
          } catch (e) {
            print('Error fetching suggestions: $e');
          } finally {
            isLoading = false;
            notifyListeners();
          }
        }
      } else {
        destinationSuggestions = [];
      }
    });
  }
}

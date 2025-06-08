// ignore_for_file: use_build_context_synchronously, avoid_print, deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cabify/core/cache/cache_helper.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:http/http.dart' as http;
import 'package:cabify/model/Crud.dart';
import 'package:flutter/material.dart';
import 'package:cabify/Screens/links.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class AddTripProvider with ChangeNotifier {
  final crud = Crud();
  bool tripAdedd = false;
  final TextEditingController fromDestinationController =
      TextEditingController();
  final TextEditingController toDestinationController = TextEditingController();
  final TextEditingController tripPriceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Future<void> addTrip({required BuildContext context}) async {
    if (formKey.currentState!.validate()) {
      if (timeAdded) {
        tripAdedd = true;
        notifyListeners();
        await crud.postData(addTripEndPoint, {
          "driverId": locator<CacheHelper>().getData(key: "id"),
          "oLatitude": selectedToDestination!["lat"].toString(),
          "oLongitude": selectedToDestination!["lon"].toString(),
          "dLatitude": selectedFromDestination!["lat"].toString(),
          "dLongitude": selectedFromDestination!["lon"].toString(),
          "date": date,
          "time": time.toString(),
          "price": double.tryParse(tripPriceController.text) ?? 0.0,
        });
        tripAdedd = false;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Trip Added Successfully")));
        fromDestinationController.text = " ";
        toDestinationController.text = " ";
        tripPriceController.text = " ";
        selectedFromDestination = null;
        selectedToDestination = null;
        date = null;
        time = null;
        formatDate = "";
        timeAdded = false;
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please, Select Date & Time")));
      }
    }
  }

  ////////////////////////////
  bool getLocation = false;
  getCurrentLocation() async {
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
    selectedFromDestination = {
      "lat": currentPosition.latitude,
      "lon": currentPosition.longitude,
      "name": "Current Location",
      "display_place": "Current Address"
    };
    setFromDestenation(selectedFromDestination!);
    getLocation = false;
    notifyListeners();
    return currentPosition;
  }

  ////////////////////////////
  DateTime timeNow = DateTime.now();
  bool timeAdded = false;
  String formatDate = "";
  String? date, time;

  selectDateAndTime({required BuildContext context}) async {
    DateTime? newDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: timeNow);
    if (newDate == null) return;
    TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: timeNow.hour, minute: timeNow.minute));
    if (newTime == null) return;
    timeNow = DateTime(
      newDate.year,
      newDate.month,
      newDate.day,
      newTime.hour,
      newTime.minute,
    );
    formatDate =
        "${DateFormat.yMMMMEEEEd().format(timeNow)} - ${DateFormat.jm().format(timeNow)}";
    date = timeNow.toIso8601String();
    time = "${DateFormat.jm().format(timeNow)}}";

    log(formatDate.toString());
    timeAdded = true;
    notifyListeners();
  }

  ////////////////////////////Request Body: {"driverId":16,"oLatitude":"30.0443879","oLongitude":"31.2357257","dLatitude":"45.8889285","dLongitude":"6.2376659","date":"2025-01-25T05:54:00.000","time":"5:54 AM}","price":"150"}
  List<Map<String, dynamic>> destinationSuggestions = [];
  Timer? _debounceTimer;
  final String _locationIqApiKey = 'pk.52c69844cb68f67a95da65d9fa143298';
  Map<String, dynamic>? selectedFromDestination;
  Map<String, dynamic>? selectedToDestination;
  String lastQuery = '';
  bool isLoading = false;
  setFromDestenation(Map<String, dynamic> destination) {
    selectedFromDestination = destination;
    fromDestinationController.text = destination["name"];
    log("----------------------------------------------------------");
    log(selectedFromDestination!.toString());
    log("----------------------------------------------------------");
    notifyListeners();
  }

  setToDestenation(Map<String, dynamic> destination) {
    selectedToDestination = destination;
    toDestinationController.text = destination["name"];
    log("----------------------------------------------------------");
    log(selectedToDestination!.toString());
    log("----------------------------------------------------------");

    notifyListeners();
  }

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

import 'dart:async';
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:cabify/Screens/links.dart';
import 'package:cabify/Screens/on_board/screens/onBoard.dart';
import 'package:cabify/model/Crud.dart';
import 'package:cabify/model/statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GoogleMapController mapController;
  final LatLng _initialPosition = const LatLng(37.7749, -122.4194);
  LatLng? _currentPosition;
  Marker? _currentLocationMarker;
  String _address = '';
  final TextEditingController _destinationController = TextEditingController();
  List<Map<String, dynamic>> _destinationSuggestions = [];
  bool _isLoading = false;
  Timer? _debounceTimer;
  Map<String, dynamic>? _selectedDestination;
  List<dynamic> fetchedData = [];

  final String _locationIqApiKey = 'pk.52c69844cb68f67a95da65d9fa143298';
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController transId = TextEditingController();
  final GlobalKey<FormState> _payKey = GlobalKey<FormState>();

  Polyline? _routePolyline;
  String _travelTime = '';
  String _distance = '';

  List<bool>? isAvailableList = List.generate(6, (index) => true);

  final BitmapDescriptor redIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);

  final BitmapDescriptor greenIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);

  List<LatLng> _generateNearbyPoints(LatLng currentPosition) {
    List<LatLng> nearbyPoints = [];
    double distance = 0.003;

    nearbyPoints.add(
        LatLng(currentPosition.latitude + distance, currentPosition.longitude));
    nearbyPoints.add(
        LatLng(currentPosition.latitude - distance, currentPosition.longitude));
    nearbyPoints.add(
        LatLng(currentPosition.latitude, currentPosition.longitude + distance));

    return nearbyPoints;
  }

  Future fetchData() async {
    Crud crud = Crud();
    final result = await crud.getData("$linkGetSeats/6");

    result.fold(
      (failure) {
        switch (failure) {
          case StatusRequest.offlinefailure:
            debugPrint("No internet connection.");
            break;
          case StatusRequest.serverfailure:
            debugPrint("Server error occurred.");
            break;
          case StatusRequest.failure:
            debugPrint("Client-side error.");
            break;
          case StatusRequest.notfound:
            debugPrint("Resource not found.");
            break;
          case StatusRequest.unauthorized:
            debugPrint("Unauthorized access.");
            break;
          case StatusRequest.forbidden:
            debugPrint("Forbidden access.");
            break;
          default:
            debugPrint("Unhandled error.");
        }
      },
      (data) {
        debugPrint("Data received: $data");
        List<dynamic> sanitizedData = data.map((item) {
          String dLatitudeStr = item['trip']['dLatitude'] ?? '';
          String dLongitudeStr = item['trip']['dLongitude'] ?? '';
          double? dLatitude = double.tryParse(dLatitudeStr);
          double? dLongitude = double.tryParse(dLongitudeStr);
          if (dLatitude == null || dLongitude == null) {
            debugPrint(
                "Invalid latitude/longitude for trip ${item['tripId']}. Setting to default values.");
            dLatitude = null; // Or use a default value like 0.0
            dLongitude = null; // Or use a default value like 0.0
          }

          return {
            ...item,
            'trip': {
              ...item['trip'],
              'dLatitude': dLatitude,
              'dLongitude': dLongitude,
            },
          };
        }).toList();
        List<dynamic> availableSeats =
            sanitizedData.where((item) => item['isAvailable'] == true).toList();

        setState(() {
          fetchedData = availableSeats;
        });
      },
    );
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationServiceDialog();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _currentLocationMarker = Marker(
        markerId: const MarkerId('currentLocation'),
        position: _currentPosition!,
        icon: redIcon,
      );
    });

    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(_currentPosition!, 15.0),
    );

    _getAddressFromLatLng(position.latitude, position.longitude);
  }

  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _address =
              '${place.street ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}';
        });
      } else {
        setState(() {
          _address = 'Address not found';
        });
      }
    } catch (e) {
      print('Error getting address: $e');
      setState(() {
        _address = 'Error occurred';
      });
    }
  }

  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Services Disabled'),
        content:
            const Text('Please enable location services to use this feature.'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              Geolocator.openLocationSettings();
            },
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('passengerId');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out successfully')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnBoardScreen()),
    );
  }

  Future<void> _fetchDestinationSuggestions(String query) async {
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      if (query.isNotEmpty) {
        setState(() {
          _isLoading = true;
        });

        try {
          final queryEncoded = Uri.encodeComponent(query);
          final url =
              'https://api.locationiq.com/v1/autocomplete?key=$_locationIqApiKey&q=$queryEncoded&limit=5&dedupe=1';
          final response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            print(data);
            if (data is List) {
              setState(() {
                _destinationSuggestions = data
                    .where((item) =>
                        item['display_name'] != null &&
                        item['display_name'].isNotEmpty)
                    .map<Map<String, dynamic>>((item) => {
                          'name': item['display_name'] ?? 'No name available',
                          'lat': double.tryParse(item['lat'].toString()) ?? 0.0,
                          'lon': double.tryParse(item['lon'].toString()) ?? 0.0,
                        })
                    .toList();
              });
            }
          } else {
            print('Failed with status code: ${response.statusCode}');
          }
        } catch (e) {
          print('Error fetching suggestions: $e');
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _destinationSuggestions = [];
        });
      }
    });
  }

  Future<void> _getTravelDetails(LatLng destination) async {
    // Show loading indicator while waiting for the API response
    setState(() {
      _isLoading = true;
    });

    // Ensure both start and destination coordinates are valid
    if (_currentPosition == null) {
      print('Current position is null');
      setState(() {
        _travelTime = 'Current location not found';
        _distance = 'Current location not found';
      });
      return;
    }

    // Debugging: Print coordinates
    print(
        'Current Position: ${_currentPosition!.longitude}, ${_currentPosition!.latitude}');
    print('Destination: ${destination.longitude}, ${destination.latitude}');

    final url = 'http://router.project-osrm.org/route/v1/driving/'
        '${_currentPosition!.longitude},${_currentPosition!.latitude};'
        '${destination.longitude},${destination.latitude}'
        '?overview=false&alternatives=false&steps=true';

    // Debugging: Print the request URL
    print('Request URL: $url');

    try {
      // Make the GET request to OSRM
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final durationInSeconds = route['duration'];
          final distanceInMeters = route['distance'];

          final duration =
              (durationInSeconds / 60).toStringAsFixed(0); // convert to minutes
          final distance =
              (distanceInMeters / 1000).toStringAsFixed(2); // convert to km

          setState(() {
            _travelTime = '$duration minutes';
            _distance = '$distance km';
            _drawRoute(
                destination); // If you have a custom route drawing function
          });
        } else {
          setState(() {
            _travelTime = 'Route not found';
            _distance = 'Route not found';
          });
        }
      } else {
        // Handle HTTP error status codes
        print('Error fetching directions: ${response.statusCode}');
        setState(() {
          _travelTime = 'Error fetching travel time';
          _distance = 'Error fetching distance';
        });
      }
    } catch (e) {
      // Catch any other errors (network, JSON parsing, etc.)
      print('Error fetching travel details: $e');
      setState(() {
        _travelTime = 'Error fetching travel time';
        _distance = 'Error fetching distance';
      });
    } finally {
      // Hide the loading indicator when the API call is completed
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _drawRoute(LatLng destination) {
    final polyline = Polyline(
      polylineId: const PolylineId('route'),
      points: [
        _currentPosition!,
        destination,
      ],
      color: Colors.blue,
      width: 4,
    );

    setState(() {
      _routePolyline = polyline;
    });
  }

  Future<void> _linkTrip() async {
    if (_selectedDestination == null) {
      print('No destination selected');
      return;
    }

    final Map<String, dynamic> tripData = {
      "driverId": 6,
      "oLatitude": _currentPosition!.latitude.toString(),
      "oLongitude": _currentPosition!.longitude.toString(),
      "dLatitude": _selectedDestination!['lat'].toString(),
      "dLongitude": _selectedDestination!['lon'].toString(),
      "date": DateTime.now().toIso8601String(),
      "time": DateTime.now().toIso8601String(),
      "price": 0,
      "seatsTotal": 1,
    };

    final crud = Crud();
    final response = await crud.postData(linkNewTrip, tripData);

    response.fold(
      (failure) {
        // Handle failure case
        Flushbar(
          message: 'Trip failed to link',
          icon: const Icon(
            Icons.wrong_location,
            size: 28.0,
            color: Colors.red,
          ),
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: BorderRadius.circular(8.0),
          margin: const EdgeInsets.all(8.0),
          backgroundColor: Colors.black.withOpacity(0.8),
          messageColor: Colors.white,
          animationDuration: const Duration(milliseconds: 300),
        ).show(context);
      },
      (data) {
        // Handle success case
        Flushbar(
          message: 'Trip successfully linked',
          icon: const Icon(
            Icons.check_circle,
            size: 28.0,
            color: Colors.green,
          ),
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: BorderRadius.circular(8.0),
          margin: const EdgeInsets.all(8.0),
          backgroundColor: Colors.black.withOpacity(0.8),
          messageColor: Colors.white,
          animationDuration: const Duration(milliseconds: 300),
        ).show(context);
      },
    );
  }

  Future<void> _linkPayment() async {
    if (_payKey.currentState!.validate()) {
      final Map<String, dynamic> PayData = {
        "bookingId": 1,
        "paymentType": "Card",
        "amount": 0,
        "transactionId": transId.text,
        "mobileNumber": phoneController.text
      };

      final crud = Crud();
      final response = await crud.postData(linkPayment, PayData);

      response.fold(
        (failure) {
          Flushbar(
            message: 'Payment Fail linked',
            icon: const Icon(
              Icons.money_off,
              size: 28.0,
              color: Colors.red,
            ),
            duration: const Duration(seconds: 3),
            flushbarPosition: FlushbarPosition.TOP,
            borderRadius: BorderRadius.circular(8.0),
            margin: const EdgeInsets.all(8.0),
            backgroundColor: Colors.black.withOpacity(0.8),
            messageColor: Colors.white,
            animationDuration: const Duration(milliseconds: 300),
          ).show(context);
        },
        (data) {
          Flushbar(
            message: 'Payment successfully linked',
            icon: const Icon(
              Icons.money,
              size: 28.0,
              color: Colors.green,
            ),
            duration: const Duration(seconds: 3),
            flushbarPosition: FlushbarPosition.TOP,
            borderRadius: BorderRadius.circular(8.0),
            margin: const EdgeInsets.all(8.0),
            backgroundColor: Colors.black.withOpacity(0.8),
            messageColor: Colors.white,
            animationDuration: const Duration(milliseconds: 300),
          ).show(context);
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {
      if (_currentLocationMarker != null) _currentLocationMarker!,
      ...(_currentPosition != null
          ? _generateNearbyPoints(_currentPosition!).map(
              (position) => Marker(
                markerId: MarkerId(position.toString()),
                position: position,
                icon: greenIcon,
              ),
            )
          : []),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('3al Tareeq'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 12,
            ),
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            compassEnabled: true,
            tiltGesturesEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            markers: markers, // Use the updated markers with red and green
            polylines: _routePolyline != null ? {_routePolyline!} : {},
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Where are you going today?',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Icon(Icons.circle,
                          color: Colors.purple, size: 12.0),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(text: _address),
                          decoration: const InputDecoration(
                            hintText: 'Choose pick up point',
                            border: InputBorder.none,
                          ),
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.red, size: 12.0),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          controller: _destinationController,
                          decoration: const InputDecoration(
                            hintText: 'Choose your destination',
                            border: InputBorder.none,
                          ),
                          onChanged: _fetchDestinationSuggestions,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (_destinationSuggestions.isNotEmpty)
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _destinationSuggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = _destinationSuggestions[index];
                          return ListTile(
                            title: Text(
                              suggestion['name'] ?? 'Unknown destination',
                            ),
                            onTap: () {
                              // Print all details of the selected suggestion
                              print('Selected suggestion details: $suggestion');

                              setState(() {
                                _selectedDestination =
                                    suggestion; // Store the selected destination
                                _destinationSuggestions = [];
                              });

                              _destinationController.text =
                                  suggestion['name'] ?? '';
                              LatLng destination = LatLng(
                                suggestion['lat'],
                                suggestion['lon'],
                              );
                              _getTravelDetails(destination);
                            },
                          );
                        },
                      ),
                    ),
                  if (_travelTime.isNotEmpty) Text('Travel Time: $_travelTime'),
                  if (_distance.isNotEmpty) Text('Distance: $_distance'),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: _destinationController.text.isNotEmpty
                          ? () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _linkTrip();
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          color: Colors.purple,
                                          child: const Column(
                                            children: [
                                              Icon(
                                                Icons.money,
                                                size: 60,
                                              ),
                                              Text(
                                                'Cash',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Form(
                                                key: _payKey,
                                                child: Column(
                                                  children: [
                                                    buildTextField(
                                                      'Mobile Number',
                                                      'Type your text here...',
                                                      controller:
                                                          phoneController,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter your mobile number';
                                                        } else if (!RegExp(
                                                                r'^[0-9]{10,15}$')
                                                            .hasMatch(value)) {
                                                          return 'Enter a valid mobile number';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    buildTextField(
                                                      'transactionId',
                                                      'Type your transactionId...',
                                                      controller: transId,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter your transactionId';
                                                        } else if (!RegExp(
                                                                r'^[0-9]{10,15}$')
                                                            .hasMatch(value)) {
                                                          return 'Enter a valid transactionId';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        _linkPayment();
                                                      },
                                                      child: const Text(
                                                          "Link Payment"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: const Text('Close'),
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          color: Colors.deepPurple,
                                          child: const Center(
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.credit_card,
                                                    size: 60,
                                                  ),
                                                  Text(
                                                    'Visa Card',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text('Close'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ],
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 6, // Subtle shadow effect
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.purple.withOpacity(0.5),
                      ).copyWith(
                        backgroundColor:
                            WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.disabled)) {
                            return Colors.grey[400];
                          }
                          return null;
                        }),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.deepPurple],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Link Trip',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          List<bool> isAvailableList =
                              List.generate(6, (index) => false);

                          return FutureBuilder<void>(
                            future: fetchData(), // This will update fetchedData
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return AlertDialog(
                                  title: const Text("Loading..."),
                                  content: const CircularProgressIndicator(),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close dialog
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return AlertDialog(
                                  title: const Text("Error"),
                                  content: const Text(
                                      'Failed to load availability data'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close dialog
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              }

                              // Data has been loaded successfully, assign to `isAvailableList`
                              if (fetchedData.isNotEmpty) {
                                // Update the availability list based on fetched data
                                isAvailableList = List.generate(
                                  6,
                                  (index) {
                                    // Map the fetched data to the availability of the first 6 seats
                                    if (index < fetchedData.length) {
                                      return fetchedData[index]['isAvailable'];
                                    } else {
                                      return true; // Default to true if there is no corresponding data
                                    }
                                  },
                                );
                              }

                              return AlertDialog(
                                content: SizedBox(
                                  height: 200, // Fixed height for the grid
                                  width: 200, // Fixed width for the grid
                                  child: StatefulBuilder(
                                    builder: (context, setState) {
                                      return GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10,
                                        ),
                                        itemCount: isAvailableList
                                            .length, // Use length instead of null-safe check
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // Safely toggle the availability state
                                                if (index <
                                                    isAvailableList.length) {
                                                  isAvailableList[index] =
                                                      !isAvailableList[index];
                                                }
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: isAvailableList[index]
                                                    ? Colors.green
                                                    : Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${index + 1}', // Display the square number
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close dialog
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.abc),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildTextField(
  String label,
  String hint, {
  bool isPassword = false,
  required TextEditingController controller,
  required String? Function(String?) validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        validator: validator,
      ),
    ],
  );
}

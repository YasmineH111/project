import 'package:cabify/Screens/links.dart';
import 'package:cabify/Screens/on_board/screens/onBoard.dart';
import 'package:cabify/core/cache/cache_helper.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:cabify/model/Crud.dart';
import 'package:cabify/model/statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDriver extends StatefulWidget {
  const HomeDriver({super.key});

  @override
  State<HomeDriver> createState() => _HomeDriverState();
}

class _HomeDriverState extends State<HomeDriver> {
  List<dynamic> fetchedData = [];
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('driverId');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out successfully')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnBoardScreen()),
    );
  }

  // Method to fetch data
  void fetch() async {
    Crud crud = Crud();
    final result = await crud.getData("$linkGetAllTrips");
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
        List<dynamic> filteredData = data
            .where((item) =>
                item['driverId'] == locator<CacheHelper>().getData(key: "id"))
            .toList();
        setState(() {
          fetchedData = filteredData;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetch(); // Fetch the data when the widget is initialized
  }

  // Method to handle Accept action
  void acceptAction(dynamic item) {
    debugPrint('Accepted trip: ${item['tripId']}');
  }

  // Method to handle Refuse action
  void refuseAction(dynamic item) {
    debugPrint('Refused trip: ${item['tripId']}');
    // You can add further logic to handle refusing the trip
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: fetchedData.isEmpty
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show loading spinner while fetching data
            : ListView.builder(
                itemCount: fetchedData.length,
                itemBuilder: (context, index) {
                  var item = fetchedData[index];

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'Trip ID: ${item['tripId']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Driver ID: ${item['driverId']}\nDetails for item $index',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            leading: const CircleAvatar(
                              backgroundColor: Colors.purple,
                              child: Icon(
                                Icons.drive_eta,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Row containing Accept and Refuse buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () => acceptAction(item),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.green, // Accept button color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                ),
                                child: const Text('Accept'),
                              ),
                              ElevatedButton(
                                onPressed: () => refuseAction(item),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.red, // Refuse button color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                ),
                                child: const Text('Refuse'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

// import 'package:cabify/Screens/links.dart';
// import 'package:cabify/Screens/onBoard.dart';
// import 'package:cabify/model/Crud.dart';
// import 'package:cabify/model/statusrequest.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomeDriver extends StatefulWidget {
//   const HomeDriver({super.key});

//   @override
//   State<HomeDriver> createState() => _HomeDriverState();
// }

// class _HomeDriverState extends State<HomeDriver> {
//   // Variable to store the fetched data
//   List<dynamic> fetchedData = [];

//   // Method to logout
//   Future<void> logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('token');
//     await prefs.remove('driverId');

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Logged out successfully')),
//     );

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const OnBoardScreen()),
//     );
//   }

//   // Method to fetch data
//   void fetchData() async {
//     Crud crud = Crud();

//     // Call the getData method without the authToken parameter
//     final result = await crud.getData(linkGetAllTrips);

//     result.fold(
//       (failure) {
//         // Handle failure cases
//         switch (failure) {
//           case StatusRequest.offlinefailure:
//             debugPrint("No internet connection.");
//             break;
//           case StatusRequest.serverfailure:
//             debugPrint("Server error occurred.");
//             break;
//           case StatusRequest.failure:
//             debugPrint("Client-side error.");
//             break;
//           case StatusRequest.notfound:
//             debugPrint("Resource not found.");
//             break;
//           case StatusRequest.unauthorized:
//             debugPrint("Unauthorized access.");
//             break;
//           case StatusRequest.forbidden:
//             debugPrint("Forbidden access.");
//             break;
//           default:
//             debugPrint("Unhandled error.");
//         }
//       },
//       (data) {
//         // Handle success cases
//         debugPrint("Data received: $data");

//         setState(() {
//           // Update the state with the fetched data
//           fetchedData = data;
//         });
//       },
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchData();  // Fetch the data when the widget is initialized
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('3al Tareeq'),
//         centerTitle: true,
//         backgroundColor: Colors.purple,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: logout,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: fetchedData.isEmpty
//             ? const Center(child: CircularProgressIndicator()) // Show loading spinner while fetching data
//             : ListView.builder(
//                 itemCount: fetchedData.length,
//                 itemBuilder: (context, index) {
//                   var item = fetchedData[index];

//                   // Customize the layout of each item in the list
//                   return Card(
//                     elevation: 4,
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       contentPadding: const EdgeInsets.all(16.0),
//                       title: Text(
//                         item.toString(), // You can modify this based on the structure of each item
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       subtitle: Text(
//                         'Details for item $index', // You can add more info here
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       leading: const CircleAvatar(
//                         backgroundColor: Colors.purple,
//                         child: Icon(
//                           Icons.drive_eta, // Replace with appropriate icon
//                           color: Colors.white,
//                         ),
//                       ),
//                       onTap: () {
//                         // Handle item tap if needed
//                       },
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }

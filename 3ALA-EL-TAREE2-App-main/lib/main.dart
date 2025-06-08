import 'package:cabify/Screens/driver/provider/add_trip_provider.dart';
import 'package:cabify/Screens/driver/screens/my_trip/provider/my_trip_provider.dart';
import 'package:cabify/Screens/driver/screens/profile/provider/profile_provider.dart';
import 'package:cabify/Screens/user/screens/find_trip/provider/find_trip_provider.dart';
import 'package:cabify/Screens/user/screens/map/provider/map_provider.dart';
import 'package:cabify/Screens/user/screens/my_seats/provider/my_seats_provider.dart';
import 'package:cabify/Screens/user/screens/pay_seat/provider/pay_seat_provider.dart';
import 'package:cabify/Screens/user/screens/profile/provider/profile_provider.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:cabify/core/routes/app_routes.dart';
import 'package:cabify/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine initial route
    final passengerId = sharedPreferences.getString("passengerId");
    final driverId = sharedPreferences.getString("driverId");

    String initialRoute;
    if (driverId != "" && driverId != null) {
      initialRoute = RouteNames.addTrip;
    } else if (passengerId != "" && passengerId != null) {
      initialRoute = RouteNames.findTripScreen;
    } else {
      initialRoute = RouteNames.onBoard;
    }

    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<AddTripProvider>(
                create: (_) => AddTripProvider()),
            ChangeNotifierProvider<FindTripProvider>(
                create: (_) => FindTripProvider()),
            ChangeNotifierProvider<ProfileProvider>(
                create: (_) => locator<ProfileProvider>()),
            ChangeNotifierProvider<DriverProfileProvider>(
                create: (_) => locator<DriverProfileProvider>()),
            ChangeNotifierProvider<MapProvider>(
                create: (_) => locator<MapProvider>()),
            ChangeNotifierProvider<MySeatsProvider>(
                create: (_) => locator<MySeatsProvider>()),
            ChangeNotifierProvider(
              create: (context) => locator<PaySeatProvider>(),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialRoute: initialRoute,
            routes: AppRoutes.routes,
          ),
        ));
  }
}

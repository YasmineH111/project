import 'package:cabify/Screens/driver/screens/add_trip/add_trip_screen.dart';
import 'package:cabify/Screens/driver/screens/feed_back/screens/feed_back_screen.dart';
import 'package:cabify/Screens/driver/screens/my_trip/screens/my_trips_screen.dart';
import 'package:cabify/Screens/driver/screens/profile/screens/profile_screen.dart';
import 'package:cabify/Screens/user/screens/about/screens/about_screen.dart';
import 'package:cabify/Screens/user/screens/feed_back/screens/feed_back_screen.dart';
import 'package:cabify/Screens/user/screens/map/screens/map_screen.dart';
import 'package:cabify/Screens/user/screens/my_seats/screens/my_seats_screen.dart';
import 'package:cabify/Screens/user/screens/pay_seat/screens/choose_payment_method_screen.dart';
import 'package:cabify/Screens/user/screens/pay_seat/screens/congratulation_screen.dart';
import 'package:cabify/Screens/user/screens/pay_seat/screens/credit_card_screen.dart';
import 'package:cabify/Screens/user/screens/pay_seat/screens/my_ticket_screen.dart';
import 'package:cabify/Screens/user/screens/pay_seat/screens/pay_seat_screen.dart';
import 'package:cabify/Screens/user/screens/find_trip/screens/find_trip_screen.dart';
import 'package:cabify/Screens/user/screens/home.dart';
import 'package:cabify/Screens/driver/homeDriver.dart';
import 'package:cabify/Screens/user/screens/login.dart';
import 'package:cabify/Screens/driver/loginDriver.dart';
import 'package:cabify/Screens/on_board/screens/onBoard.dart';
import 'package:cabify/Screens/user/screens/pay_seat/screens/vodafone_cash_screen.dart';
import 'package:cabify/Screens/user/screens/profile/screens/profile_screen.dart';
import 'package:cabify/Screens/user/screens/trips/screens/trips_screen.dart';
import 'package:cabify/Screens/user/screens/seats/screens/seats_screen.dart';
import 'package:cabify/core/routes/route_names.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    RouteNames.login: (context) => const LoginScreen(),
    RouteNames.home: (context) => const Home(),
    RouteNames.homeDriver: (context) => const HomeDriver(),
    RouteNames.onBoard: (context) => const OnBoardScreen(),
    RouteNames.loginDriver: (context) => const LoginDriver(),
    RouteNames.addTrip: (context) => const AddTripScreen(),
    RouteNames.findTripScreen: (context) => const FindTripScreen(),
    RouteNames.tripsScreen: (context) => const TripsScreen(),
    RouteNames.seatsScreen: (context) => const SeatsScreen(),
    RouteNames.paySeatScreen: (context) => const PaySeatScreen(),
    RouteNames.choosePaymentMethodScreen: (context) =>
        const ChoosePaymentMethodScreen(),
    RouteNames.profileScreen: (context) => const ProfileScreen(),
    RouteNames.mapScreen: (context) => const MapScreen(),
    RouteNames.aboutScreen: (context) => const AboutScreen(),
    RouteNames.feedbackScreen: (context) => const FeedBackScreen(),
    RouteNames.vodafoneCashScreen: (context) => const VodafoneCashScreen(),
    RouteNames.creditCardScreen: (context) => const CreditCardScreen(),
    RouteNames.congratulationScreen: (context) => const CongratulationScreen(),
    RouteNames.myTicketScreen: (context) => const MyTicketScreen(),
    RouteNames.mySeatScreen: (context) => const MySeatsScreen(),
    RouteNames.driverFeedBackScreen: (context) => const DriverFeedBackScreen(),
    RouteNames.driverProfileScreen: (context) => const DriverProfileScreen(),
    RouteNames.myTripsScreen: (context) => const MyTripsScreen(),
    RouteNames.mySeatsScreen: (context) => const SeatsScreen(),
  };
}

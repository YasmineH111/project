import 'dart:developer';

import 'package:cabify/core/cache/cache_helper.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:cabify/core/routes/route_names.dart';
import 'package:cabify/core/services/api/api_consumer.dart';
import 'package:cabify/core/services/api/end_points.dart';
import 'package:flutter/material.dart';

class PaySeatProvider with ChangeNotifier {
  final vodafoneController = TextEditingController();
  final creditCardController = TextEditingController();
  final vodafoneKey = GlobalKey<FormState>();
  final creditCardKey = GlobalKey<FormState>();
  final paymentVodafoneKey = GlobalKey<FormState>();
  final paymentCreditKey = GlobalKey<FormState>();
  final amoutController = TextEditingController();
  String paymentType = '';
  final ApiConsumer apiConsumer;
  PaySeatProvider({required this.apiConsumer});
  /////////////////////
  set selectPaymentType(String type) {
    paymentType = type;
    notifyListeners();
  }

  /////////////////////
  paySeat({
    required BuildContext context,
  }) async {
    if (paymentVodafoneKey.currentState!.validate()) {
      try {
        await apiConsumer.post(
          EndPoints.paySeat,
          data: {
            "bookingId": await locator<CacheHelper>()
                .getData(key: "bookedId")
                .toString(),
            "paymentType": paymentType,
            "amount": double.parse(amoutController.text),
            "transactionId": paymentType == "Vodafone Cash"
                ? vodafoneController.text
                : creditCardController.text,
            "mobileNumber": paymentType == "Vodafone Cash"
                ? vodafoneController.text
                : creditCardController.text,
          },
        );
        locator<CacheHelper>().saveData(key: "name", value: "phone");
        amoutController.clear();
        vodafoneController.clear();
        creditCardController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Payment Done"),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.congratulationScreen, (_) => false);
      } catch (e) {
        log(e.toString());
      }
    }
  }
}

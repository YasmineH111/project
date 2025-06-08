import 'package:cabify/Screens/user/screens/pay_seat/widgets/pay_seat_screen_body.dart';
import 'package:flutter/material.dart';

class PaySeatScreen extends StatelessWidget {
  const PaySeatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PaySeatScreenTicket(),
    );
  }
}

import 'package:cabify/core/widgets/custom_auth_elevated_button.dart';
import 'package:cabify/core/routes/route_names.dart';
import 'package:flutter/material.dart';

class DriverOrUser extends StatelessWidget {
  const DriverOrUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'WELCOME',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomElevatedButton(
              title: "USER",
              route: RouteNames.login,
            ),
            CustomElevatedButton(
              title: "DRIVER",
              route: RouteNames.loginDriver,
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

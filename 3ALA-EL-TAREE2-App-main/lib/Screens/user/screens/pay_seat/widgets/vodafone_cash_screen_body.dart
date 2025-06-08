import 'package:cabify/Screens/user/screens/pay_seat/provider/pay_seat_provider.dart';
import 'package:cabify/Screens/user/screens/pay_seat/widgets/payment_list_tile.dart';
import 'package:cabify/Screens/user/screens/pay_seat/widgets/payment_method_field.dart';
import 'package:cabify/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class VodafoneCashScreenBody extends StatelessWidget {
  const VodafoneCashScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: Consumer<PaySeatProvider>(builder: (context, provider, child) {
          return Form(
            key: provider.paymentVodafoneKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    spacing: 20.h,
                    children: [
                      PaymentListTile(
                        paymentTitle: "Vodafone Cash",
                        fontSize: 42.sp,
                      ),
                      PaymentMethodField(
                        label: "Type your number .....",
                        title: "Your mobile number",
                        maxLenght: 11,
                        controller: provider.vodafoneController,
                      ),
                      const PaymentMethodField(
                        label: "Type your number .....",
                        title: " Receiver mobile number",
                        maxLenght: 11,
                      ),
                      PaymentMethodField(
                        label: "Type amount .....",
                        title: "Amount of money",
                        controller: provider.amoutController,
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    title: "Done",
                    onPressed: () {
                      provider.paySeat(context: context);
                    },
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

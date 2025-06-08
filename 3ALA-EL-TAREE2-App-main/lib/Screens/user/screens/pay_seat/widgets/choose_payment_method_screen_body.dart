import 'package:cabify/Screens/user/screens/pay_seat/provider/pay_seat_provider.dart';
import 'package:cabify/Screens/user/screens/pay_seat/widgets/payment_method.dart';
import 'package:cabify/core/routes/route_names.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChoosePaymentMethodScreenBody extends StatelessWidget {
  const ChoosePaymentMethodScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.7,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r), color: Colors.white),
        child: Consumer<PaySeatProvider>(builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Choose Payment method",
                style: AppTextStyles.title20KBlueColor,
              ),
              const Divider(
                thickness: 1.5,
              ),
              Form(
                key: provider.vodafoneKey,
                child: Column(
                  spacing: 20.h,
                  children: [
                    PaymentMethod(
                      label: "Enter Received amount",
                      paymentTitle: "Vodafone Cash",
                      controller: provider.vodafoneController,
                      maxLenght: 11,
                    ),
                    CustomElevatedButton(
                      title: "Submit",
                      onPressed: () {
                        if (provider.vodafoneKey.currentState!.validate()) {
                          provider.selectPaymentType = "Vodafone cash";

                          Navigator.pushNamed(
                              context, RouteNames.vodafoneCashScreen);
                        }
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.w),
                    child: const Text("Or"),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              Form(
                key: provider.creditCardKey,
                child: Column(
                  spacing: 20.h,
                  children: [
                    PaymentMethod(
                      label: "Enter Transaction ID",
                      paymentTitle: "credit card",
                      controller: provider.creditCardController,
                      maxLenght: 16,
                    ),
                    CustomElevatedButton(
                      title: "Submit",
                      onPressed: () {
                        if (provider.creditCardKey.currentState!.validate()) {
                          provider.selectPaymentType = "Credit Card";
                          Navigator.pushNamed(
                              context, RouteNames.creditCardScreen);
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

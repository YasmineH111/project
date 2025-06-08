import 'package:cabify/Screens/user/screens/pay_seat/provider/pay_seat_provider.dart';
import 'package:cabify/Screens/user/screens/pay_seat/widgets/payment_method_field.dart';
import 'package:cabify/core/assets/images/app_images.dart';
import 'package:cabify/core/routes/route_names.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_elevated_button.dart';
import 'package:cabify/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CreditCardScreenBody extends StatelessWidget {
  const CreditCardScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
        child: Consumer<PaySeatProvider>(builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Form(
              key: provider.paymentVodafoneKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: 30.h,
                children: [
                  Text(
                    "Add a bank card",
                    style: AppTextStyles.title42KBlueColor,
                  ),
                  PaymentMethodField(
                    title: "Card number",
                    label: "Typr your number here ..........",
                    controller: provider.creditCardController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(AppImages.cardImage),
                      Image.asset(AppImages.visaImage),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.25,
                        child: const Column(
                          children: [
                            Text("MM"),
                            CustomTextField(
                              label: "",
                              style: AppTextStyles.title16Grey,
                              maxLength: 2,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.25,
                        child: const Column(
                          children: [
                            Text("YY"),
                            CustomTextField(
                              label: "",
                              style: AppTextStyles.title16Grey,
                              maxLength: 2,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const PaymentMethodField(
                    title: "CVV",
                    label: "type your cvv here ......",
                    maxLenght: 3,
                  ),
                  PaymentMethodField(
                    title: "Amount Of money",
                    label: "type your cvv here ......",
                    controller: provider.amoutController,
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

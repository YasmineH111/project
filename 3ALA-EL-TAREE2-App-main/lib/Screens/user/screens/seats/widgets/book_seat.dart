import 'package:cabify/Screens/user/screens/seats/widgets/user_details_for_book_seat.dart';
import 'package:cabify/core/function/open_dialog.dart';
import 'package:cabify/core/styles/app_text_styles.dart';
import 'package:cabify/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookSeat extends StatelessWidget {
  const BookSeat({
    super.key,
    required this.seatNumber,
    required this.tripId,
  });
  final int tripId;
  final int seatNumber;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SizedBox(
          height: 200.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 20.h,
            children: [
              Text(
                "Enter your details for booking seat $seatNumber ?",
                style: AppTextStyles.title20KBlueColor,
                textAlign: TextAlign.center,
              ),
              Row(
                spacing: 10.w,
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      title: "Close",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomElevatedButton(
                      title: "Book",
                      onPressed: () {
                        Navigator.pop(context);
                        openDialog(
                          context: context,
                          widget: UserDetailsForBookSeat(
                            seatNumber: seatNumber,
                            tripId: tripId,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cabify/Screens/user/screens/seats/widgets/book_seat.dart';
import 'package:cabify/Screens/user/screens/seats/widgets/custom_seat_card_details.dart';
import 'package:cabify/Screens/user/screens/seats/widgets/not_avalible_seat.dart';
import 'package:cabify/Screens/user/screens/seats/widgets/seat_app_bar.dart';
import 'package:cabify/Screens/user/screens/seats/widgets/seat_type.dart';
import 'package:cabify/core/function/open_dialog.dart';
import 'package:cabify/model/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeatNumberDetails extends StatelessWidget {
  const SeatNumberDetails({
    super.key,
    required this.tripModel,
    required this.to,
  });
  final TripModel tripModel;
  final String to;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 200.h,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 280.h,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            CustomSeatCardDetails(
              price: tripModel.price.toString(),
              startedAt: tripModel.date!,
              to: to,
            ),
            const SeatAppBar(),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.white,
                ),
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  itemCount: 15,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 48.w,
                    mainAxisSpacing: 48.h,
                  ),
                  itemBuilder: (context, index) {
                    return SeatType(
                      gender: tripModel.seats![index].genderPreference!,
                      onTap: () {
                        tripModel.seats![index].seatNumber == 1
                            ? openDialog(
                                context: context,
                                widget: const NotAvilableSeat())
                            : tripModel.seats![index].isAvailable!
                                ? openDialog(
                                    context: context,
                                    widget: BookSeat(
                                        tripId: tripModel.seats![index].tripId,
                                        seatNumber:
                                            tripModel.seats![index].seatNumber))
                                : openDialog(
                                    context: context,
                                    widget: const NotAvilableSeat());
                      },
                      isBooked: tripModel.seats![index].isAvailable!,
                      seatId: tripModel.seats![index].seatNumber,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

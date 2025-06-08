import 'package:cabify/Screens/user/screens/feed_back/provider/feed_back_provider.dart';
import 'package:cabify/Screens/user/screens/feed_back/widgets/feed_back_and_rating.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FeedBackScreenBody extends StatelessWidget {
  const FeedBackScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => locator<FeedBackProvider>(),
      child: Consumer<FeedBackProvider>(builder: (context, provider, child) {
        return Center(
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.85,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
              child: Center(
                child: !provider.feedBackUploaded
                    ? const CircularProgressIndicator()
                    : FeedBackAndRating(
                        provider: provider,
                      ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

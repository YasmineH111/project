import 'dart:developer';

import 'package:cabify/core/cache/cache_helper.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:flutter/material.dart';

class FeedBackProvider with ChangeNotifier {
  final feedBackController = TextEditingController();
  double rating = 0;
  Map<String, dynamic> feedBack = {};
  bool feedBackUploaded = false;
  FeedBackProvider() {
    getFeedBack();
  }
  getFeedBack() async {
    String? cachedRating =
        await locator<CacheHelper>().getData(key: "userRting");
    if (cachedRating != null && cachedRating.isNotEmpty) {
      rating = double.tryParse(cachedRating) ?? 0;
    } else {
      rating = 0;
    }
    log("Rating: $rating");
    String? cachedFeedBack =
        await locator<CacheHelper>().getData(key: "UserFeedBack");
    if (cachedFeedBack != null && cachedFeedBack.isNotEmpty) {
      feedBackController.text = cachedFeedBack;
    } else {
      feedBackController.text = "";
    }

    feedBackUploaded = true;
    notifyListeners();
  }

  updateFeedBack({required BuildContext context}) async {
    await locator<CacheHelper>().saveData(
      key: "UserFeedBack",
      value: feedBackController.text,
    );
    await locator<CacheHelper>().saveData(
      key: "userRting",
      value: rating.toString(),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("FeedBack Saved Successfully "),
      ),
    );
    Navigator.pop(context);
    log("FeedBack Saved Successfully ");
  }
}

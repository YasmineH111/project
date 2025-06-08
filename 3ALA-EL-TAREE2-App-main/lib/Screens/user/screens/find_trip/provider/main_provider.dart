import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  final key = GlobalKey<ScaffoldState>();

  openDrawer() {
    key.currentState?.openDrawer();
  }

  closeDrawer() {
    key.currentState?.closeDrawer();
  }
}

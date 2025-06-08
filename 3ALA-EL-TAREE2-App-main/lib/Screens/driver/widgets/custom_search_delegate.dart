import 'package:cabify/Screens/driver/widgets/custom_icon_button.dart';
import 'package:cabify/Screens/driver/widgets/suggestions_body.dart';
import 'package:cabify/Screens/user/screens/find_trip/widgets/suggestions_body_for_user.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({
    required this.searchAbout,
    required this.userType,
  });
  final String searchAbout;
  final String userType;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      CustomIconButton(
        icon: Icons.close,
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return CustomIconButton(
      icon: Icons.arrow_back,
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return userType == "Driver"
        ? SuggestionsBodyForDriver(
            query: query,
            searchAbout: searchAbout,
          )
        : SuggestionsBodyForUser(
            query: query,
            searchAbout: searchAbout,
          );
  }
}

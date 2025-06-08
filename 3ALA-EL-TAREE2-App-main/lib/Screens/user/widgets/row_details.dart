import 'package:flutter/material.dart';

class RowDetails extends StatelessWidget {
  const RowDetails({
    super.key,
    required this.firstChild,
    required this.secondChild,
  });
  final Widget firstChild;
  final Widget secondChild;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [firstChild, secondChild],
    );
  }
}

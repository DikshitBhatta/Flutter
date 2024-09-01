import 'package:flutter/material.dart';

class Spoon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(20.00),
      child: Icon(
        Icons.food_bank,
        size: 100.00,
      ),
    ));
  }
}

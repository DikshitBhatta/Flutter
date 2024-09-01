import 'package:flutter/material.dart';

class Reminder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(20.00),
      child: Icon(
        Icons.access_alarm,
        size: 100.00,
      ),
    ));
  }
}

import 'package:flutter/material.dart';

class Graditude extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.00),
        child: Icon(
          Icons.sentiment_satisfied,
          size: 100.00,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Padding(
      padding: EdgeInsets.all(20.00),
      child: Icon(
        Icons.sports_football,
        size: 100.00,
      ),
    ));
  }
}

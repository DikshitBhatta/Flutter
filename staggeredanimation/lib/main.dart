import 'package:flutter/material.dart';
import 'package:animationcontroller/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Animat",
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.lightBlue),
      ),
      home: Home(),
    );
  }
}

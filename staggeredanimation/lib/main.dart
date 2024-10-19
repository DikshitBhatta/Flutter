import 'package:flutter/material.dart';
import 'package:animationcontroller/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Animat",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.lightBlue),
      ),
      home: Home(),
    );
  }
}

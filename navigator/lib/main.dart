import 'package:flutter/material.dart';
import 'package:navigator/Pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Navigator example",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        appBarTheme: AppBarTheme(color: Colors.lightBlue.shade300),
      ),
      home: Home(),
    );
  }
}

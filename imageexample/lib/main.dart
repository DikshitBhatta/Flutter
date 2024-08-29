import 'package:flutter/material.dart';
import 'package:imageexample/Pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Imageexample',
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          appBarTheme: AppBarTheme(color: Colors.amber)),
      home: Home(),
    );
  }
}

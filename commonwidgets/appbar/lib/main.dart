import 'package:flutter/material.dart';
import 'package:appbar/pages/home.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Common Widget',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        primaryColor: Colors.lightGreen,
        appBarTheme: const AppBarTheme(
          color: Colors.lightGreen, // Ensure AppBar uses the primary color
        ),
      ),
      home: Home(),
    );
  }
}

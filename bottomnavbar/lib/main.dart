import 'package:flutter/material.dart';
import 'package:bottomnavbar/Pages/Home.dart';
void main()=> runApp(MyApp());

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bottomnavbarexample',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.lightBlue),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.lightBlue),
      ),
      home:Home(),
    );
  }
}
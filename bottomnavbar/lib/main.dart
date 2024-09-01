import 'package:flutter/material.dart';
import 'package:bottomnavbar/Pages/Home.dart';
void main()=> runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bottomnavbarexample',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.lightBlue),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.lightBlue),
      ),
      home:Home(),
    );
  }
}
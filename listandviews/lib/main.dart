import 'package:flutter/material.dart';
import 'package:listandviews/Pages/home.dart';
void main()=>runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'listandviewsexample',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        appBarTheme: AppBarTheme(color: Colors.lightGreen),
      ),
      home: Home(),
    );
  }
}
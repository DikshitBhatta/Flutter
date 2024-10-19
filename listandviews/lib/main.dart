import 'package:flutter/material.dart';
import 'package:listandviews/Pages/home.dart';
void main()=>runApp(MyApp());

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'listandviewsexample',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        appBarTheme: const AppBarTheme(color: Colors.lightGreen),
      ),
      home: Home(),
    );
  }
}
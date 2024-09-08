import 'package:flutter/material.dart';
import 'package:journal/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal',
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          appBarTheme: AppBarTheme(color: Colors.lightGreen),
          canvasColor: Colors.lightGreen.shade50,
          bottomAppBarTheme: BottomAppBarTheme(color: Colors.lightGreen)),
      home: Home(),
    );
  }
}

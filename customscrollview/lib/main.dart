import 'package:flutter/material.dart';
import 'package:customscrollview/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'customscrollexample',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        appBarTheme: AppBarTheme(color: Colors.lightGreen),
      ),
      home: Home(),
    );
  }
}

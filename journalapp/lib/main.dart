import 'package:flutter/material.dart';
import 'package:journalapp/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'customscrollexample',
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          appBarTheme: const AppBarTheme(color: Colors.lightGreen),
          bottomAppBarTheme: const BottomAppBarTheme(color: Colors.lightGreen)),
      home: Home(),
    );
  }
}

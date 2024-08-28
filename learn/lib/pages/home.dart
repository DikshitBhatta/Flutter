import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 40,
                backgroundColor: Colors.yellow)),
      ),
      body: Container(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:animationcontroller/widget/animated_ballon.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation Controller"),
      ),
      body: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
         AnimatedballoonWidget(),
        ],
      )),
    );
  }
}

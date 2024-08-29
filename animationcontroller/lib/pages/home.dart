import 'package:flutter/material.dart';
import 'package:animationcontroller/widget/animated_ballon.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _hasShownPopup = false;
  void _restartGame() {
    if (_hasShownPopup) {
      setState(() {
        _hasShownPopup = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation Controller"),
      ),
      body: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          AnimationcontrollerWidget(onBallonbrust: _restartGame),
          AnimationcontrollerWidget(onBallonbrust: _restartGame),
          AnimationcontrollerWidget(onBallonbrust: _restartGame),
          AnimationcontrollerWidget(onBallonbrust: _restartGame),
        ],
      )),
    );
  }
}

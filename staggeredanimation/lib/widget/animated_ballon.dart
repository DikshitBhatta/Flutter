import 'dart:collection';

import 'package:flutter/material.dart';

class AnimatedballoonWidget extends StatefulWidget {
  const AnimatedballoonWidget({super.key});

  @override
  _AnimatedBallonWidgetState createState() => _AnimatedBallonWidgetState();
}

class _AnimatedBallonWidgetState extends State<AnimatedballoonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationfloatup;
  late Animation<double> _animationgrowup;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double ballonHeight = MediaQuery.of(context).size.height / 2;
    double ballonWidth = MediaQuery.of(context).size.width / 3;
    double ballonBottomLocation =
        MediaQuery.of(context).size.height - ballonHeight - 50.00;

    _animationfloatup = Tween(begin: ballonBottomLocation, end: 0.00).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.00, 1.00, curve: Curves.bounceInOut)));
    _animationgrowup = Tween(begin: 50.00, end: ballonWidth).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.5, curve: Curves.elasticInOut)));
    return AnimatedBuilder(
        animation: _animationfloatup,
        builder: (context, child) {
          return Container(
            margin: EdgeInsets.only(top: _animationfloatup.value),
            width: _animationgrowup.value,
            child: child,
          );
        },
        child: GestureDetector(
          onTap: () {
            if (_controller.isCompleted) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          },
          child: Image.asset(
            "assets/images/ballon.png",
            height: ballonHeight,
            width: ballonWidth,
          ),
        ));
  }
}

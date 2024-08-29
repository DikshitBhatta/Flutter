import 'package:flutter/material.dart';

class AnimationcontrollerWidget extends StatefulWidget {
  @override
  _AnimatedBallonState createState() => _AnimatedBallonState();
}

class _AnimatedBallonState extends State<AnimationcontrollerWidget>
    with TickerProviderStateMixin {
  late AnimationController _controllerfloatup;
  late AnimationController _controllerGrowsize;
  late Animation<double> _animationfloatup;
  late Animation<double> _animationGrowsize;
  @override
  void initState() {
    super.initState();
    _controllerfloatup =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controllerfloatup.reverse(); // Automatically comes down
            } else if (status == AnimationStatus.dismissed) {
              // Burst effect when it reaches the bottom
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Balloon Burst!"),
                  content: Text("The balloon has burst!"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _controllerfloatup.forward(); // Restart animation
                      },
                      child: Text("Try Again"),
                    ),
                  ],
                ),
              );
            }
          });
    _controllerGrowsize =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
  }

  @override
  void dispose() {
    _controllerfloatup.dispose();
    _controllerGrowsize.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double _ballonHeight = MediaQuery.of(context).size.height / 2.50;
    double _ballonWidth = MediaQuery.of(context).size.width / 3.00;
    double _ballonBottomLocation =
        MediaQuery.of(context).size.height - _ballonHeight;
    _animationfloatup = Tween(begin: _ballonBottomLocation, end: 0.0).animate(
        CurvedAnimation(
            parent: _controllerfloatup, curve: Curves.fastOutSlowIn));
    _animationGrowsize = Tween(begin: 50.00, end: _ballonWidth).animate(
        CurvedAnimation(
            parent: _controllerfloatup, curve: Curves.elasticInOut));
    _controllerfloatup.forward();
    return Center(
        child: AnimatedBuilder(
      animation: _animationfloatup,
      builder: (context, child) {
        return Container(
          child: child,
          margin: EdgeInsets.only(
            top: _animationfloatup.value,
          ),
          width: _animationGrowsize.value,
        );
      },
      child: GestureDetector(
        onTap: () {
          if (_controllerfloatup.isAnimating) {
            _controllerfloatup.stop();
            _controllerfloatup.forward();
            _controllerGrowsize.forward();
          } else {
            _controllerfloatup.forward();
            _controllerGrowsize.forward();
          }
        },
        child: Image.asset(
          "assets/images/ballon.png",
          height: _ballonHeight,
          width: _ballonWidth,
        ),
      ),
    ));
  }
}

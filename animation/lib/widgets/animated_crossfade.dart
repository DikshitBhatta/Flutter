import 'package:flutter/material.dart';

class AnimatedCrossfadeWidget extends StatefulWidget {
  @override
  _AnimatedCrossfadeWidgetState createState() =>
      _AnimatedCrossfadeWidgetState();
}

class _AnimatedCrossfadeWidgetState extends State<AnimatedCrossfadeWidget> {
  bool _crossfadeStateShow = true;
  void _crossfade() {
    setState(() {
      _crossfadeStateShow = _crossfadeStateShow ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedCrossFade(
              firstChild: Container(
                color: Colors.amber,
                height: 100.00,
                width: 100.00,
              ),
              secondChild: Container(
                color: Colors.green,
                height: 100.00,
                width: 300.00,
              ),
              crossFadeState: _crossfadeStateShow
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              sizeCurve: Curves.bounceOut,
              duration: Duration(milliseconds: 500),
            ),
            Positioned.fill(
                //flatbutton is reszed to its maximum size above the continer widget
                child: TextButton(
                    onPressed: () => _crossfade(),
                    child: Text("Crossfade Animation")))
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatefulWidget {
  const AnimatedContainerWidget({super.key});

  @override
  _AnimatedContainerWidgetState createState() =>
      _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget> {
  final double _height = 200.00;
  double _width = 200.00;
  _increaseWidth() {
    setState(() {
      _width = _width >= (MediaQuery.of(context).size.width)
          ? 100.00
          : _width += 50.00;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.bounceInOut,
          color: Colors.amber,
          height: _height,
          width: _width,
          child: TextButton(
            onPressed: () => _increaseWidth(),
            child: Text('Tap To Grow $_width'),
          ),
        )
      ],
    );
  }
}

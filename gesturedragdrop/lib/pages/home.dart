import 'package:flutter/material.dart';
import 'package:gesturedragdrop/methods/buildgesturedetctor.dart';
import 'package:gesturedragdrop/pages/gesturemovingscaling.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _gestureDetected;
  Color? _paintedColor;
  GestureDetector _buildGestureDetector() {
    return GestureDetector(
      onTap: () {
        print('onTap');
        _displayGestureDetector('onTap');
      },
      onDoubleTap: () {
        print('onDoubleTap');
        _displayGestureDetector('onDoubleTap');
      },
      onLongPress: () {
        print('onLongPress');
        _displayGestureDetector('onLongPress');
      },
      onPanUpdate: (details) {
        print('onPanUpdate: $details');
        _displayGestureDetector('onPanUpdate \n$details');
      },
      child: Container(
        color: Colors.lightGreen.shade100,
        width: double.infinity,
        padding: EdgeInsets.all(24.00),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.access_alarm,
              size: 98.00,
            ),
            Text('$_gestureDetected')
          ],
        ),
      ),
    );
  }

  Draggable<int> _buildDraggable() {
    return Draggable(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.palette,
            color: Colors.deepOrange,
            size: 48.00,
          ),
          Text('Drag me below to change Color'),
        ],
      ),
      childWhenDragging: Icon(
        Icons.palette,
        color: Colors.grey,
        size: 48.00,
      ),
      feedback: Icon(
        Icons.brush,
        color: Colors.orange,
        size: 80.00,
      ),
      data: Colors.deepOrange.value,
    );
  }

  DragTarget<int> _buildDragTarget() {
    return DragTarget(
      onAcceptWithDetails: (details) {
        _paintedColor = Color(details.data);
      },
      builder: (BuildContext context, List<dynamic> acceptedData,
              List<dynamic> rejectedData) =>
          acceptedData.isEmpty
              ? Text(
                  "Drag To and see the color change",
                  style: TextStyle(color: _paintedColor),
                )
              : Text(
                  "Painting Color: ${acceptedData[0]}",
                  style: TextStyle(
                      color: Color(acceptedData[0]),
                      fontWeight: FontWeight.bold),
                ),
    );
  }

  void _displayGestureDetector(String gesture) {
    setState(() {
      _gestureDetected = gesture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Detector'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildGestureDetector(),
            Divider(
              color: Colors.black,
              height: 44.00,
            ),
            _buildDraggable(),
            Divider(
              height: 40.00,
            ),
            _buildDragTarget(),
            Divider(
              color: Colors.black,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Widgetmovingscaling(),
                    ),
                  );
                },
                child: Text('Gesturemovingandscaling'))
          ],
        ),
      )),
    );
  }
}

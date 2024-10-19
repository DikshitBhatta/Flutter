import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Widgetmovingscaling extends StatefulWidget {
  const Widgetmovingscaling({super.key});
  @override
  _WidgetmovingscalingState createState() => _WidgetmovingscalingState();
}

class _WidgetmovingscalingState extends State<Widgetmovingscaling> {
  Offset _startLastOffset = Offset.zero;
  Offset _lastOffset = Offset.zero;
  Offset _currentOffset = Offset.zero;
  double _Lastscale = 1.0;
  double _currentScale = 1.0;

  Widget _buildBody(BuildContext context) {
    void onScaleStart(ScaleStartDetails details) {
      print('ScaleStartDetails: $details');
      _startLastOffset = details.focalPoint;
      _lastOffset = _currentOffset;
      _Lastscale = _currentScale;
    }

    void onScaleUpdate(ScaleUpdateDetails details) {
      print('ScaleUpdatedetails: $details - scale: ${details.scale}');

      setState(() {
        // Calculate the current scale based on the previous scale and the new scale from the gesture
        double currentScale = _Lastscale * details.scale;

        // Clamp the scale value to be within the desired range (0.5 to 16.0)
        if (currentScale < 0.5) {
          currentScale = 0.5;
        } else if (currentScale > 16.0) {
          currentScale = 16.0;
        }

        // Update the state with the new scale
        _currentScale = currentScale;

        // Calculate the translation offset based on the scale and movement
        Offset offsetAdjustedForScale = Offset(
          (_startLastOffset.dx - _lastOffset.dx) / _Lastscale,
          (_startLastOffset.dy - _lastOffset.dy) / _Lastscale,
        );

        // Update the current offset based on the new focal point and adjusted offset
        _currentOffset =
            details.focalPoint - (offsetAdjustedForScale * currentScale);

        print('_scale: $currentScale - _Lastscale: $_Lastscale');
        print(
            'OffsetAdjustedforscale: $offsetAdjustedForScale - _currentOffset: $_currentOffset');
      });
    }

    void resettoDefaultValues() {
      _startLastOffset = Offset.zero;
      _lastOffset = Offset.zero;
      _currentOffset = Offset.zero;
      _Lastscale = 1.0;
      _currentScale = 1.0;
    }

    void onDoubleTap() {
      print('onDoubleTap');
      double currentScale = _Lastscale * 2.0;
      if (currentScale > 16.0) {
        currentScale = 1.0;
        resettoDefaultValues();
      }
      _Lastscale = currentScale;
      setState(() {
        _currentScale = currentScale;
      });
    }

    void onLongPress() {
      print('onLongPress');
      setState(() {
        resettoDefaultValues();
      });
    }

    void setscalebig() {
      double bscale = _Lastscale * 2;
      _Lastscale = bscale;
      setState(() {
        _currentScale = bscale;
      });
      if (bscale > 16.0) {
        _currentScale:
        1.0;
        resettoDefaultValues();
      }
    }

    void setscalesmall() {
      double cScale = _Lastscale / 2;
      _Lastscale = cScale;

      setState(() {
        _currentScale = cScale;
      });
      if (cScale < 0.1) {
        _currentScale = 1.0;
        resettoDefaultValues();
      }
    }

    Positioned positionedInkwellAndInkRespose(BuildContext context) {
      return Positioned(
          top: 50.00,
          width: MediaQuery.of(context).size.width,
          child: Container(
            color: Colors.white54,
            height: 56.00,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  splashColor: Colors.lightGreenAccent,
                  highlightColor: Colors.lightBlueAccent,
                  onTap: setscalesmall,
                  onDoubleTap: setscalebig,
                  onLongPress: onLongPress,
                  child: Container(
                    height: 48.00,
                    width: 128.00,
                    color: Colors.black12,
                    child: Icon(
                      Icons.touch_app,
                      size: 32.00,
                    ),
                  ),
                ),
                InkResponse(
                  splashColor: Colors.pinkAccent,
                  highlightColor: Colors.redAccent,
                  onTap: setscalesmall,
                  onDoubleTap: setscalebig,
                  onLongPress: onLongPress,
                  child: Container(
                    height: 48.00,
                    width: 128.00,
                    color: Colors.black12,
                    child: Icon(
                      Icons.touch_app,
                      size: 32.00,
                    ),
                  ),
                )
              ],
            ),
          ));
    }

    return GestureDetector(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _transformscaleandTranslate(),
          _transformMatrix4(),
          _positionedStatusBar(context),
          positionedInkwellAndInkRespose(
            context,
          )
        ],
      ),
      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
    );
  }

  Transform _transformscaleandTranslate() {
    return Transform.scale(
      scale: _currentScale,
      child: Transform.translate(
        offset: _currentOffset,
        child: const Image(
          image: AssetImage("assets/images/elephant.jpeg"),
        ),
      ),
    );
  }

  Transform _transformMatrix4() {
    return Transform(
      transform: Matrix4.identity()
        ..scale(_currentScale, _currentScale)
        ..translate(_currentOffset.dx, _currentOffset.dy),
      alignment: FractionalOffset.center,
      child: const Image(image: AssetImage("assets/images/elephant.jpeg")),
    );
  }

  Positioned _positionedStatusBar(BuildContext context) {
    return Positioned(
      top: 0.00,
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: Colors.white24,
        height: 50.00,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('Scale:${_currentScale.toStringAsFixed(4)}'),
            Text('Current:$_currentOffset'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesturemovingandscaling'),
      ),
      body: _buildBody(context),
    );
  }
}

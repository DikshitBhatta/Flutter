import 'package:flutter/material.dart';

class Fly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.shortestSide;
    return Scaffold(
      appBar: AppBar(
        title: Text('Paint Brush'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.00),
          child: Column(
            children: <Widget>[
              Center(
                child: Text("Paint brush"),
              ),
              Hero(
                tag: 'Paint',
                child: Icon(
                  Icons.format_paint,
                  color: Colors.red,
                  size: _width,
                ),
              ),
              Text('''This is a paint brush.
                      We use it to paint
                    and blah blah blah.''')
            ],
          ),
        ),
      ),
    );
  }
}

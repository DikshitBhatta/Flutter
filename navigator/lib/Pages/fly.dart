import 'package:flutter/material.dart';

class Fly extends StatelessWidget {
  const Fly({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.shortestSide;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paint Brush'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.00),
          child: Column(
            children: <Widget>[
              const Center(
                child: Text("Paint brush"),
              ),
              Hero(
                tag: 'Paint',
                child: Icon(
                  Icons.format_paint,
                  color: Colors.red,
                  size: width,
                ),
              ),
              const Text('''This is a paint brush.
                      We use it to paint
                    and blah blah blah.''')
            ],
          ),
        ),
      ),
    );
  }
}

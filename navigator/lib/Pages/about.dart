import 'dart:io';
import 'fly.dart';

import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Page'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Container(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.00),
          child: GestureDetector(
            child: const Hero(
              tag: 'Paint',
              child: Icon(
                Icons.format_paint,
                color: Colors.red,
                size: 20.00,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Fly()));
            },
          ),
        ),
      ),
    );
  }
}

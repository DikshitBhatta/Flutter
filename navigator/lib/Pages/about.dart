import 'dart:io';

import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Page'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Container(),
          ),
        ],
      ),
      body: SafeArea(child: Text('This is about page')),
    );
  }
}

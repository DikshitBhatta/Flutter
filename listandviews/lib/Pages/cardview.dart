import 'package:flutter/material.dart';

class CardView extends StatefulWidget {
  @override
  _CardviewState createState() => _CardviewState();
}

class _CardviewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Card(
            elevation: 5.00,
            color: Colors.white,
            margin: EdgeInsets.all(20.00),
            shape: StadiumBorder(),
            child: Column(
              children: <Widget>[
                Text(
                  'Dikshit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 48.00,
                      color: Colors.deepOrange),
                ),
                Text(
                  'Bhatta',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          Card(
            elevation: 5.00,
            shape: StadiumBorder(),
            margin: EdgeInsets.all(16.00),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Text(
                  'New Text',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 40.00, fontWeight: FontWeight.bold),
                ),
                Text(
                  'New Try',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w100),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

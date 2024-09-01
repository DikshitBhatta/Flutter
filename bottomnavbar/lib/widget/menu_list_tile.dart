import 'package:flutter/material.dart';
import 'package:bottomnavbar/Pages/graditude.dart';
import 'package:bottomnavbar/Pages/reminder.dart';
import 'package:bottomnavbar/Pages/spoon.dart';

class MenuListTile extends StatefulWidget {
  @override
  _MenuListTileState createState() => _MenuListTileState();
}

class _MenuListTileState extends State<MenuListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            leading: Icon(Icons.sentiment_satisfied),
            title: Text('Gratitude'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Graditude()),
              );
            }),
        ListTile(
            leading: Icon(Icons.access_alarm),
            title: Text('Reminder'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Reminder()),
              );
            }),
        ListTile(
            leading: Icon(Icons.food_bank_sharp),
            title: Text('Foodbank'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Graditude()),
              );
            }),
        Divider(color: Colors.grey),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

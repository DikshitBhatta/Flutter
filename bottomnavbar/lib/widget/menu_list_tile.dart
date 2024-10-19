import 'package:flutter/material.dart';
import 'package:bottomnavbar/Pages/graditude.dart';
import 'package:bottomnavbar/Pages/reminder.dart';
import 'package:bottomnavbar/Pages/spoon.dart';

class MenuListTile extends StatefulWidget {
  const MenuListTile({super.key});

  @override
  _MenuListTileState createState() => _MenuListTileState();
}

class _MenuListTileState extends State<MenuListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            leading: const Icon(Icons.sentiment_satisfied),
            title: const Text('Gratitude'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Graditude()),
              );
            }),
        ListTile(
            leading: const Icon(Icons.access_alarm),
            title: const Text('Reminder'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Reminder()),
              );
            }),
        ListTile(
            leading: const Icon(Icons.food_bank_sharp),
            title: const Text('Foodbank'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Graditude()),
              );
            }),
        const Divider(color: Colors.grey),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

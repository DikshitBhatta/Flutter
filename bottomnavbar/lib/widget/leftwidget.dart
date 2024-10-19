import 'package:bottomnavbar/widget/menu_list_tile.dart';
import 'package:bottomnavbar/Pages/reminder.dart';
import 'package:flutter/material.dart';

class Leftwidget extends StatelessWidget {
  const Leftwidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Pika Pika',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text(
              'Pikachu@gmail.com',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            currentAccountPicture: const Icon(
              Icons.face,
              size: 75.00,
              color: Colors.white,
            ),
            otherAccountsPictures: <Widget>[
              IconButton(
                icon: const Icon(Icons.bookmark_outline,
                    color: Colors.white, fill: 1.00),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Reminder()));
                },
              ),
            ],
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/pokemon.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          MenuListTile(),
        ],
      ),
    );
  }
}

import 'package:bottomnavbar/widget/menu_list_tile.dart';
import 'package:flutter/material.dart';

class Leftwidget extends StatelessWidget {
  const Leftwidget({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'Pika Pika',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              'Pikachu@gmail.com',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            currentAccountPicture: Icon(
              Icons.face,
              size: 75.00,
              color: Colors.white,
            ),
            otherAccountsPictures: <Widget>[
              Icon(Icons.bookmark_outline),
            ],
            decoration: BoxDecoration(
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

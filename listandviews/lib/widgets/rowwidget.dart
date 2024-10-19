import 'package:flutter/material.dart';

class Rowwidget extends StatelessWidget {
  const Rowwidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.motorcycle),
      title: Text(
        'Motor Bike',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'You can take a ride',
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w100),
      ),
    );
  }
}

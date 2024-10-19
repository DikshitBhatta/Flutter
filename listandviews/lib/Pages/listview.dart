import 'package:flutter/material.dart';

class Listview extends StatefulWidget {
  const Listview({super.key});

  @override
  _ListviewState createState() => _ListviewState();
}

class _ListviewState extends State<Listview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            elevation: 5.00,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.00),
                borderSide: const BorderSide(color: Colors.blue)),
            child: const ListTile(
              leading: Icon(Icons.flight),
              title: Text('Airplane 1'),
              trailing: Text(
                '10%',
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 10.00,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'cool',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Card(
            elevation: 5.00,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.00),
                borderSide: const BorderSide(color: Colors.blue)),
            child: const ListTile(
              leading: Icon(Icons.flight),
              title: Text('Airplane 2'),
              trailing: Text(
                '10%',
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 10.00,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'cool',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.car_repair),
            title: Text(
              'Car',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Car for rent'),
          )
        ],
      ),
    );
  }
}

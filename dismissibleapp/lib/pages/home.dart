import 'package:flutter/material.dart';
import 'package:dismissibleapp/classes/trips.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Trips> _trips = [];
  @override
  void initState() {
    super.initState();
    _trips
      ..add(Trips(Id: '0', tripName: 'Rome', tripLocation: 'Italy'))
      ..add(Trips(Id: '1', tripName: 'Paris', tripLocation: 'France'))
      ..add(Trips(Id: '2', tripName: 'Tokyo', tripLocation: 'Japan'))
      ..add(Trips(Id: '3', tripName: 'ApiMountain', tripLocation: 'Api'))
      ..add(Trips(Id: '4', tripName: 'SaipalMountain', tripLocation: 'Saipal'))
      ..add(Trips(Id: '5', tripName: 'kathmandu', tripLocation: 'Nepal'))
      ..add(Trips(Id: '6', tripName: 'Sailung', tripLocation: 'Sailung'))
      ..add(Trips(
          Id: '7', tripName: 'SagarmathaMountain', tripLocation: 'Sagarmatha'))
      ..add(Trips(Id: '8', tripName: 'Fewavisit', tripLocation: 'Pokhara'))
      ..add(Trips(Id: '9', tripName: 'Illam', tripLocation: 'Illam'));
  }

  ListTile _buildListTile(int index) {
    return ListTile(
      title: Text('${_trips[index].tripName}'),
      subtitle: Text('${_trips[index].tripLocation}'),
      leading: const Icon(Icons.flight),
      trailing: const Icon(Icons.fastfood),
    );
  }

  Container _buildCompleteTrip() {
    return Container(
      color: Colors.green,
      child: const Padding(
        padding: EdgeInsets.all(16.00),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.done,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Container _buildRemoveTrip() {
    return Container(
      color: Colors.red,
      child: const Padding(
        padding: EdgeInsets.all(16.00),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.remove,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  _markTripcompleted(index) {
    print('${_trips[index].tripName} is completed');
  }

  _deleteTrip(index) {
    print('${_trips[index].tripName} is deleted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _trips.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(_trips[index].Id!),
            background: _buildCompleteTrip(),
            secondaryBackground: _buildRemoveTrip(),
            onDismissed: (DismissDirection direction) {
              direction == DismissDirection.startToEnd
                  ? _markTripcompleted(index)
                  : _deleteTrip(index);
              setState(() {
                _trips.removeAt(index);
              });
            },
            child: _buildListTile(index),
          );
        },
      ),
    );
  }
}

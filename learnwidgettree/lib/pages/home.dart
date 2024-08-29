import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WidgetTree',
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.00),
            child: Column(
              children: <Widget>[
                _buildHorizontalRow(),
                Padding(
                  padding: EdgeInsets.all(16.00),
                ),
                _buildhorizontalrow3(),
                Divider(),
                const PopupMenuButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildhorizontalrow3() {
    return Row(
      children: <Widget>[
        _buildverticalcolumn(),
      ],
    );
  }

  Column _buildverticalcolumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          color: Colors.yellow,
          height: 60.00,
          width: 60.00,
        ),
        Padding(
          padding: EdgeInsets.all(16.00),
        ),
        Container(
          color: Colors.amber,
          height: 40.00,
          width: 40.00,
        ),
        Padding(
          padding: EdgeInsets.all(16.00),
        ),
        Container(
          color: Colors.brown,
          height: 20.00,
          width: 20.00,
        ),
        Divider(),
        _buildHorizontalRow2(),
        Divider(),
        Text('End of line'),
      ],
    );
  }
}

Row _buildHorizontalRow() {
  return Row(
    children: <Widget>[
      Container(
        color: Colors.blue,
        height: 40.0,
        width: 40.0,
      ),
      Padding(
        padding: EdgeInsets.all(16.00),
      ),
      Expanded(
        child: Container(
          color: Colors.amber,
          height: 40.00,
          width: 40.00,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(16.00),
      ),
      Container(
        color: Colors.brown,
        height: 40.00,
        width: 40.00,
      ),
    ],
  );
}

Row _buildHorizontalRow2() {
  return Row(
    children: <Widget>[
      CircleAvatar(
        backgroundColor: Colors.lightGreen,
        radius: 100.0,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.yellow,
              height: 100.00,
              width: 100.00,
            ),
            Container(
              color: Colors.amber,
              height: 60.00,
              width: 60.00,
            ),
            Container(
              color: Colors.brown,
              height: 40.00,
              width: 40.00,
            ),
          ],
        ),
      )
    ],
  );
}

class ToDoMenuItem {
  final String? title;
  final Icon? icon;
  ToDoMenuItem({this.title, this.icon});
}

List<ToDoMenuItem> foodMenuList = [
  ToDoMenuItem(title: 'Breakfast', icon: Icon(Icons.food_bank)),
  ToDoMenuItem(title: 'cycling', icon: Icon(Icons.bike_scooter)),
  ToDoMenuItem(title: 'walking', icon: Icon(Icons.assist_walker)),
  ToDoMenuItem(title: 'football', icon: Icon(Icons.sports_football)),
];

class PopupMenuButtonWidget extends StatelessWidget {
  const PopupMenuButtonWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen.shade100,
      child: PopupMenuButton<ToDoMenuItem>(
        icon: Icon(Icons.view_list),
        onSelected: ((valueSelected) {
          print('valueSelected: ${valueSelected}');
        }),
        itemBuilder: (BuildContext context) {
          return foodMenuList.map(
            (ToDoMenuItem toDoMenuItem) {
              return PopupMenuItem<ToDoMenuItem>(
                value: toDoMenuItem,
                child: Row(
                  children: <Widget>[
                    Icon(toDoMenuItem.icon!.icon),
                    Text(toDoMenuItem.title!),
                  ],
                ),
              );
            },
          ).toList();
        },
      ),
    );
  }
}

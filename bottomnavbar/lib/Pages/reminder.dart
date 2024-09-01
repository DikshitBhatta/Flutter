import 'package:flutter/material.dart';
import 'package:bottomnavbar/methods/gridicon.dart';

class Reminder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<IconData> _iconList = GridIcons().getIconList();

    return GridView.extent(
      maxCrossAxisExtent: 175.00,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(8.0),
      children: List.generate(20, (index) {
        print('_buildgridviewextene $index');
        return Card(
          margin: EdgeInsets.all(8.00),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  _iconList[index],
                  color: Colors.blue,
                  size: 20,
                ),
                Divider(),
                Text('Photo $index'),
              ],
            ),
            onTap: () {
              print('Row $index');
            },
          ),
        );
      }),
    );
  }
}

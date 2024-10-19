import 'package:flutter/material.dart';
import 'package:bottomnavbar/methods/gridicon.dart';

class Reminder extends StatelessWidget {
  const Reminder({super.key});

  @override
  Widget build(BuildContext context) {
    List<IconData> iconList = GridIcons().getIconList();

    return GridView.extent(
      maxCrossAxisExtent: 175.00,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(8.0),
      children: List.generate(20, (index) {
        print('_buildgridviewextene $index');
        return Card(
          margin: const EdgeInsets.all(8.00),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconList[index],
                  color: Colors.blue,
                  size: 20,
                ),
                const Divider(),
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

import 'package:flutter/material.dart';
import 'package:bottomnavbar/methods/gridicon.dart';

class GridviewBuildWidget extends StatelessWidget {
  const GridviewBuildWidget({super.key});
  @override
  Widget build(BuildContext context) {
    List<IconData> iconList = GridIcons().getIconList();
    return Container(
      child: GridView.builder(
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150.00),
        itemBuilder: (BuildContext context, int index) {
          print('Index $index');
          return Card(
            child: InkWell(
              child: Column(
                children: <Widget>[
                  Icon(
                    iconList[index],
                    color: Colors.blue,
                    size: 40.00,
                  ),
                  const Divider(),
                  Text('Index $index'),
                ],
              ),
              onTap: () {
                print('Row Printed ${1 + index}');
              },
            ),
          );
        },
      ),
    );
  }
}

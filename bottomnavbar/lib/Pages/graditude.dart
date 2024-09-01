import 'package:flutter/material.dart';
import 'package:bottomnavbar/methods/gridicon.dart';

class Graditude extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<IconData> _iconList = GridIcons().getIconList();
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.all(8.00),
        children: List.generate(70, (index) {
          print('_buildGridview $index');
          return Card(
            margin: EdgeInsets.all(8.00),
            child: InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    _iconList[0],
                    size: 48.00,
                    color: Colors.blue,
                  ),
                  Divider(),
                  Text(
                    'Index $index',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.00),
                  )
                ],
              ),
              onTap: () {
                print('Row $index');
              },
            ),
          );
        }),
      ),
    );
  }
}

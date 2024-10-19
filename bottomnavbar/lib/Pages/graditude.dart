import 'package:flutter/material.dart';
import 'package:bottomnavbar/methods/gridicon.dart';

class Graditude extends StatelessWidget {
  const Graditude({super.key});

  @override
  Widget build(BuildContext context) {
    List<IconData> iconList = GridIcons().getIconList();
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(8.00),
        children: List.generate(70, (index) {
          print('_buildGridview $index');
          return Card(
            margin: const EdgeInsets.all(8.00),
            child: InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    iconList[0],
                    size: 48.00,
                    color: Colors.blue,
                  ),
                  const Divider(),
                  Text(
                    'Index $index',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16.00),
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

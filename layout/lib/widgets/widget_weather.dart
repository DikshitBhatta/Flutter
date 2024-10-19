import 'package:flutter/material.dart';

class WidgetWeather extends StatelessWidget {
  const WidgetWeather({super.key});
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        Icon(
          Icons.sunny,
          color: Colors.amber,
          weight: 100.00,
        ),
        SizedBox(
          width: 20.00,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '81° Clear',
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.deepOrange),
            ),
            Text(
              '4500 San Alpho Drive, Dallas, TX United States',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w100),
            ),
          ],
        ),
      ],
    );
  }
}

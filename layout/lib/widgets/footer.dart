import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CircleAvatar(
          radius: 40.00,
          backgroundImage: AssetImage("assets/images/burger.jpg"),
        ),
        CircleAvatar(
          radius: 40.00,
          backgroundImage: AssetImage("assets/images/melon.jpg"),
        ),
        CircleAvatar(
          radius: 40.00,
          backgroundImage: AssetImage("assets/images/pasta.jpeg"),
        ),
        SizedBox(
          width: 15.00,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.cake),
            Icon(Icons.star),
            Icon(Icons.music_note),
          ],
        )
      ],
    );
  }
}

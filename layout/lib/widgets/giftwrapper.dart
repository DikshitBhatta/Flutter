import 'package:flutter/material.dart';

class Giftwrapper extends StatelessWidget {
  const Giftwrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        7,
        (int index) {
          return Chip(
            label: Text(
              "Gift ${index + 1}",
              style: TextStyle(fontSize: 10.00),
            ),
            avatar: Icon(Icons.card_giftcard),
          );
        },
      ),
    );
  }
}

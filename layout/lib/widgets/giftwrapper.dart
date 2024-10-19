import 'package:flutter/material.dart';

class Giftwrapper extends StatelessWidget {
  const Giftwrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        7,
        (int index) {
          return Chip(
            label: Text(
              "Gift ${index + 1}",
              style: const TextStyle(fontSize: 10.00),
            ),
            avatar: const Icon(Icons.card_giftcard),
          );
        },
      ),
    );
  }
}

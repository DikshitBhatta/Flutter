import 'dart:ffi';

import 'package:flutter/material.dart';

class SilverListWidget extends StatelessWidget {
  const SilverListWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(
          3,
          (int index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text('Index ${index + 1}'),
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
              ),
              title: Text('Row ${index + 1}'),
              subtitle: Text('Try this one ${index + 1}'),
              trailing: Icon(Icons.star_border),
            );
          },
        ),
      ),
    );
  }
}

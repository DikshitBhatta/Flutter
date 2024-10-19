import 'dart:ffi';

import 'package:flutter/material.dart';

class SilverListWidget extends StatelessWidget {
  const SilverListWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(
          3,
          (int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
                child: Text('Index ${index + 1}'),
              ),
              title: Text('Row ${index + 1}'),
              subtitle: Text('Try this one ${index + 1}'),
              trailing: const Icon(Icons.star_border),
            );
          },
        ),
      ),
    );
  }
}

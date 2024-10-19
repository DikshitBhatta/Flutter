import 'package:flutter/material.dart';

class SilverGridWidget extends StatelessWidget {
  const SilverGridWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
        sliver: SliverGrid(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.child_friendly,
                      size: 48,
                      color: Colors.amber,
                    ),
                    const Divider(),
                    Text("Grid ${index + 1}"),
                  ],
                ),
              );
            }, childCount: 12),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3)));
  }
}

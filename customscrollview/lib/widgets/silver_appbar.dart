import 'package:flutter/material.dart';

class SilverAppBarWidget extends StatelessWidget {
  const SilverAppBarWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.brown,
      forceElevated: true,
      expandedHeight: 250.00,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Parallex Effect',
          style: TextStyle(color: Colors.white),
        ),
        background: Image(image: AssetImage("assets/images/k2.jpg")),
      ),
    );
  }
}

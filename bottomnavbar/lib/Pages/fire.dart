import 'package:flutter/material.dart';
import 'package:bottomnavbar/widget/gridviewbuilder.dart';

class Fire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: const GridviewBuildWidget(),
      ),
    );
  }
}

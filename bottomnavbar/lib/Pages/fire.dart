import 'package:flutter/material.dart';
import 'package:bottomnavbar/widget/gridviewbuilder.dart';

class Fire extends StatelessWidget {
  const Fire({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: GridviewBuildWidget(),
      ),
    );
  }
}

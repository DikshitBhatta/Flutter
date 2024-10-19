import 'package:animation/widgets/animated_crossfade.dart';
import 'package:animation/widgets/animated_opacity.dart';
import 'package:flutter/material.dart';
import 'package:animation/widgets/animated_container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "WidthAnimation",
            ),
          ),
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            AnimatedContainerWidget(),
            const Divider(),
            AnimatedCrossfadeWidget(),
            const Divider(),
            AnimatedOpacityWidget(),
          ],
        )));
  }
}

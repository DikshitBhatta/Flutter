import 'package:flutter/material.dart';
import 'package:listandviews/widgets/headerwidget.dart';
import 'package:listandviews/widgets/rowwidget.dart';
import 'package:listandviews/widgets/rowwithcard.dart';

class Listviewtile extends StatefulWidget {
  @override
  _ListviewtileState createState() => _ListviewtileState();
}

class _ListviewtileState extends State<Listviewtile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          print('Rendering index: $index');
          if (index == 0) {
            return const Headerwidget();
          } else if (index >= 1 && index <= 3) {
            return const Rowwithcard();
          } else {
            return const Rowwidget();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:listandviews/Pages/listview.dart';

class Rowwithcard extends StatelessWidget {
  const Rowwithcard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Listview(),
    );
  }
}

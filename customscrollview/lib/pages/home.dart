import 'package:flutter/material.dart';
import 'package:customscrollview/widgets/silver_appbar.dart';
import 'package:customscrollview/widgets/silver_list.dart';
import 'package:customscrollview/widgets/silver_grid.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomScrollbar'),
        elevation: 0.00,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          const SilverAppBarWidget(),
          const SilverListWidget(),
          const SilverGridWidget(),
        ],
      ),
    );
  }
}

import 'package:bottomnavbar/widget/leftwidget.dart';
import 'package:flutter/material.dart';
import 'package:bottomnavbar/Pages/fire.dart';
import 'package:bottomnavbar/Pages/ball.dart';
import 'package:bottomnavbar/Pages/spoon.dart';

class Birthday extends StatefulWidget {
  @override
  _birthdayState createState() => _birthdayState();
}

class _birthdayState extends State<Birthday>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(_tabChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  void _tabChanged() {
    if (_tabController!.indexIsChanging) {
      print('Tab Changed : ${_tabController!.index}');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Drawer'),
        ),
        drawer: const Leftwidget(),
        body: SafeArea(
          child: TabBarView(controller: _tabController, children: [
            Fire(),
            Ball(),
            Spoon(),
          ]),
        ),
        bottomNavigationBar: TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black45,
          tabs: [
            Tab(
              icon: Icon(Icons.sports_football),
              text: 'Football',
            ),
            Tab(
              icon: Icon(Icons.fireplace_sharp),
              text: 'Fire',
            ),
            Tab(
              icon: Icon(Icons.food_bank),
              text: 'Foodbank',
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:bottomnavbar/Pages/birthday.dart';
import 'package:bottomnavbar/Pages/graditude.dart';
import 'package:bottomnavbar/Pages/reminder.dart';

class Home extends StatefulWidget {
  @override
  _Homestate createState() => _Homestate();
}

class _Homestate extends State<Home> {
  int _currentIndex = 0;
  List _listpages = [];
  Widget? _currentPage;
  void initState() {
    super.initState();
    _listpages
      ..add(Birthday())
      ..add(Graditude())
      ..add(Reminder());
    _currentPage = Birthday();
  }

  void _changePage(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
      _currentPage = _listpages[selectedIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomNavBarExample'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.00),
          child: _currentPage,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'Birthday'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sentiment_satisfied,
            ),
            label: 'Gratitude',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm), label: 'Reminder'),
        ],
        onTap: (selectedIndex) => _changePage(selectedIndex),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:listandviews/Pages/cardview.dart';
import 'package:listandviews/Pages/listview.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List _listpages = [];
  Widget? _currentPage;
  void initState() {
    super.initState();
    _listpages
      ..add(CardView())
      ..add(Listview());
    _currentPage = CardView();
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
        title: Text('List and views'),
      ),
      body: Container(
        child: _currentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: 'CardView'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Listview'),
        ],
        onTap: (selectedIndex) => _changePage(selectedIndex),
      ),
    );
  }
}

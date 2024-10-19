import 'package:flutter/material.dart';
import 'package:listandviews/Pages/cardview.dart';
import 'package:listandviews/Pages/listview.dart';
import 'package:listandviews/Pages/listviewtile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List _listpages = [];
  Widget? _currentPage;
  @override
  void initState() {
    super.initState();
    _listpages
      ..add(CardView())
      ..add(Listview())
      ..add(Listviewtile());
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
        title: const Text('List and views'),
      ),
      body: Container(
        child: _currentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'CardView',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'ListTile',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt_outlined,
              ),
              label: 'Listview')
        ],
        onTap: (selectedIndex) => _changePage(selectedIndex),
      ),
    );
  }
}

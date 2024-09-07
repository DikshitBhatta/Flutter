import 'package:flutter/material.dart';
import 'package:journalapp/classes/database.dart';
import 'package:journalapp/pages/editentry.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Database _database;
  Future<List<Journal>> _loadJournals() async {
    await DatabaseFileRoutines().readJorunals().then((journalsJson) {
      _database = databaseFromJson();
      _database.journal
          .sort((comp1, comp2) => comp2.data.compareTo(comp1.data));
    });
    return _database.journal;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My journal'),
      ),
      /*body: FutureBuilder(
        initialData: [],
        future: _loadJournals(),
        builder: (BuildContext context, AsyncSnapshot snapshot ){
          return !snapshot.hasData
          ?
          Center(child: CircularProgressIndicator(),)
          :
          _buildListViewSeperated(snapshot);
    
        }
        ),*/
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(padding: EdgeInsets.all(24.00)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          tooltip: 'Add Journal Entry',
          child: Icon(Icons.add),
          onPressed: () {}),
    );
  }
}

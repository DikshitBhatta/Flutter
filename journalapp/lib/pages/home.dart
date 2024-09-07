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
      _database = databaseFromJson(journalsJson);
      _database.journal
          .sort((comp1, comp2) => comp2.date.compareTo(comp1.date));
    });
    return _database.journal;
  }

  void _addorEditJournal({bool? add, int? index, Journal? journal}) async {
    JournalEdit _journalEdit = JournalEdit(action: [], journal: journal!);
    _journalEdit = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Editentry(
          add: add,
          index: index,
          journalEdit: _journalEdit,
        ),
        fullscreenDialog: true,
      ),
    );
    switch (_journalEdit.action) {
      case 'Save':
        if (add) {
          setState(() {
            _database.journal.add(_journalEdit.journal);
          });
        } else {
          setState(() {
            _database.journal[index] = _journalEdit.journal;
          });
        }
        DatabaseFileRoutines().writeJournals(databaseToJson(_database));
        break;

      case "Cancel":
        break;

      case "default":
        break;
    }
  }

  Widget _buildListViewSeperated(AsyncSnapshot snapshot) {
    return ListView.separated(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        String _titleDate = DateFormat.yMMMd()
            .format(DateTime.parse(snapshot.data[index].date));
        String _subtitle =
            snapshot.data[index].mood + '\n' + snapshot.data[index].note;
        return Dismissible(
          key: Key(snapshot.data[index].id),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(left: 16.00),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: ListTile(
              leading: Column(
                  children: <Widget>[
                Text(
                  DateFormat.d()
                      .format(DateTime.parse(snapshot.data[index].date)),
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 32.00,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat.E().format(
                    DateTime.parse(snapshot.data[index].date),
                  ),
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
                  title: Text(
                    _titleData,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(_subtitle),
                  onTap: () {
                    _addorEditJournal(
                      add: false,
                      index: index,
                      journal = snapshot.data[index],
                    );
                  })),
          ondismissed: (direction) {
            setState(() {
              _database.journal.removeAt(index);
            });
          },
          DatabaseFileRoutines().writeJournals(databaseToJson(_database)),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.grey,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My journal'),
      ),
      body: FutureBuilder(
          initialData: [],
          future: _loadJournals(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return !snapshot.hasData
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _buildListViewSeperated(snapshot);
          }),
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

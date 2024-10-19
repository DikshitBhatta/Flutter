import 'package:flutter/material.dart';
import 'package:journalapp/classes/database.dart';
import 'package:journalapp/pages/editentry.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Database _database;
  Future<List<Journal>> _loadJournals() async {
    await DatabaseFileRoutines().readJorunals().then((journalsJson) {
      _database = databaseFromJson(journalsJson);
      _database.journal
          .sort((comp1, comp2) => comp2.date!.compareTo(comp1.date!));
    });
    return _database.journal;
  }

  void _addorEditJournal({bool? add, int? index, Journal? journal}) async {
    JournalEdit journalEdit = JournalEdit(action: " ", journal: journal!);
    journalEdit = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Editentry(
          add: add,
          index: index,
          journalEdit: journalEdit,
        ),
        fullscreenDialog: true,
      ),
    );
    switch (journalEdit.action) {
      case 'Save':
        if (add!) {
          setState(() {
            _database.journal.add(journalEdit.journal);
          });
        } else {
          setState(() {
            _database.journal[index!] = journalEdit.journal;
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
        String titleDate = DateFormat.yMMMd()
            .format(DateTime.parse(snapshot.data[index].date));
        String subtitle =
            snapshot.data[index].mood + '\n' + snapshot.data[index].note;
        return Dismissible(
          key: Key(snapshot.data[index].id),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(left: 16.00),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: ListTile(
              leading: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        DateFormat.d()
                            .format(DateTime.parse(snapshot.data[index].date)),
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 32.00,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat.E().format(
                        DateTime.parse(snapshot.data[index].date),
                      ),
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              title: Text(
                titleDate,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(subtitle),
              onTap: () {
                _addorEditJournal(
                  add: false,
                  index: index,
                  journal: snapshot.data[index],
                );
              }),
          onDismissed: (direction) {
            setState(() {
              _database.journal.removeAt(index);
            });

            DatabaseFileRoutines().writeJournals(databaseToJson(_database));
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Colors.grey,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My journal'),
      ),
      body: FutureBuilder(
          initialData: const [],
          future: _loadJournals(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return !snapshot.hasData
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _buildListViewSeperated(snapshot);
          }),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(padding: EdgeInsets.all(24.00)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          tooltip: 'Add Journal Entry',
          child: const Icon(Icons.add),
          onPressed: () {
            _addorEditJournal(add: true, index: -1, journal: Journal());
          }),
    );
  }
}

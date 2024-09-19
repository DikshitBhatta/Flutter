import 'package:flutter/material.dart';
import 'package:journal/blocs/login_bloc.dart';
import 'package:journal/pages/login.dart';
import 'package:journal/blocs/authentication_bloc.dart';
import 'package:journal/blocs/authentication_bloc_provider.dart';
import 'package:journal/blocs/homebloc.dart';
import 'package:journal/blocs/homeblocProvider.dart';
import 'package:journal/blocs/journalentry_bloc.dart';
import 'package:journal/blocs/journalentrybloc_Provider.dart';
import 'package:journal/classes/mood_icon.dart';
import 'package:journal/classes/formatdates.dart';
import 'package:journal/model/journal.dart';
import 'package:journal/services/authentication.dart';
import 'package:journal/services/db_firestore.dart';
import 'package:journal/pages/edit_entry.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthenticationBloc? _authenticationBloc;
  Homebloc? _homebloc;
  String? _uid;
  MoodIcons? _moodIcons;
  Formatdates? _formatdates;
  LoginBloc? _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(AuthenticationService());
  }

  @override
  void didChangeDepedencies() {
    super.didChangeDependencies();
    _authenticationBloc =
        AuthenticationBlocProvider.of(context).authenticationBloc;
    _homebloc = Homeblocprovider.of(context).homebloc;
    _uid = Homeblocprovider.of(context).uid;
  }

  @override
  void dispose() {
    _homebloc!.dispose();
    super.dispose();
  }

  void _addOrEditJournal({bool? add, Journal? journal}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => JournalentryblocProvider(
          journalEditBloc:
              JournalEditBloc(add!, journal!, DbFirestoreServices()),
          child: EditEntry(),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  Future<bool> _confirmDeleteJournal() async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Journal'),
            content: Text('Are you sure want to delete the Journal?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text('Cancel')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text('Delete'),
              ),
            ],
          );
        });
  }

  Widget _buildListViewSeparated(AsyncSnapshot snapshot) {
    return ListView.separated(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        String? _titleDate = _formatdates!
            .dateFormatShortMonthDayYear(snapshot.data[index].date);
        String? _subtitle =
            snapshot.data[index].mood + "\n" + snapshot.data[index].note;
        return Dismissible(
            key: Key(snapshot.data[index].documentId),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: ListTile(
              leading: Column(
                children: <Widget>[
                  Text(
                    _formatdates!
                        .dateFormatDayNumber(snapshot.data[index].date)!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0,
                      color: Colors.lightGreen,
                    ),
                  ),
                  Text(_formatdates!
                      .dateFormatShortDayName(snapshot.data[index].date)!),
                ],
              ),
              trailing: Transform(
                transform: Matrix4.identity()
                  ..rotateZ(
                      _moodIcons!.getMoodRotation(snapshot.data[index].mood)!),
                alignment: Alignment.center,
                child: Icon(
                  _moodIcons!.getMoodIcon(snapshot.data[index].mood),
                  color: _moodIcons!.getMoodColor(snapshot.data[index].mood),
                  size: 42.00,
                ),
              ),
              title: Text(
                _titleDate!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(_subtitle!),
              onTap: () {
                _addOrEditJournal(
                  add: false,
                  journal: snapshot.data[index],
                );
              },
            ),
            confirmDismiss: (direction) async {
              bool confirmDelete = await _confirmDeleteJournal();
              if (confirmDelete) {
                _homebloc!.deleteJournal.add(snapshot.data[index]);
              }
            });
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
        title: Text(
          "Journal",
          style: TextStyle(
            color: Colors.lightGreen.shade800,
          ),
        ),
        elevation: 0.00,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(32.00),
          child: Container(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen, Colors.lightGreen.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _authenticationBloc!.logOutUser
                  .add(true.toString()); //Add signmout method
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.lightGreen.shade800,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _homebloc!.listJournal,
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return _buildListViewSeparated(snapshot);
          } else {
            return Center(
              child: Container(
                child: Text("Add jounrals:"),
              ),
            );
          }
        }),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.00,
        child: Container(
          height: 44.00,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen.shade50, Colors.lightGreen],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _addOrEditJournal(add: true, journal: Journal(uid: _uid));
        },
        tooltip: 'Add Journal Entry',
        backgroundColor: Colors.lightGreen.shade300,
        child: Icon(Icons.add),
      ),
    );
  }
}

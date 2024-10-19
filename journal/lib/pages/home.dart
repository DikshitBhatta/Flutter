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
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthenticationBloc? _authenticationBloc;
  Homebloc? _homebloc;
  String? _uid;
  MoodIcons? moodIcons;
  Formatdates? formatdates;
  LoginBloc? _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(AuthenticationService());
    moodIcons = MoodIcons();
    formatdates = Formatdates();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authenticationBloc =
        AuthenticationBlocProvider.of(context)?.authenticationBloc;
    _homebloc = Homeblocprovider.of(context)?.homebloc;
    _uid = Homeblocprovider.of(context)?.uid;
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
          child: const EditEntry(),
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
            title: const Text('Delete Journal'),
            content: const Text('Are you sure want to delete the Journal?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancel')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Delete'),
              ),
            ],
          );
        });
  }

  Widget _buildListViewSeparated(AsyncSnapshot snapshot) {
    if (moodIcons == null || formatdates == null) {
      return const Center(
        child: Text('Error: MoodIcons and Formatdates is not initialized'),
      );
    }
    if (!snapshot.hasData || snapshot.data.isEmpty) {
      return const Center(
        child: Text('No journal entries found.'),
      );
    }

    return ListView.separated(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        String? titleDate = formatdates!
                .dateFormatShortMonthDayYear(snapshot.data[index].date) ??
            DateTime.now().toString();
        String? subtitle =
            snapshot.data[index].mood + "\n" + snapshot.data[index].note ?? ' ';
        return Dismissible(
            key: Key(snapshot.data[index].documentId),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: ListTile(
              leading: Column(
                children: <Widget>[
                  Text(
                    formatdates!
                        .dateFormatDayNumber(snapshot.data[index].date)!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27.0,
                      color: Colors.lightGreen,
                    ),
                  ),
                  Text(formatdates!
                      .dateFormatShortDayName(snapshot.data[index].date)!),
                ],
              ),
              trailing: Transform(
                transform: Matrix4.identity()
                  ..rotateZ(
                      moodIcons!.getMoodRotation(snapshot.data[index].mood)!),
                alignment: Alignment.center,
                child: Icon(
                  moodIcons!.getMoodIcon(snapshot.data[index].mood),
                  color: moodIcons!.getMoodColor(snapshot.data[index].mood),
                  size: 42.00,
                ),
              ),
              title: Text(
                titleDate!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                subtitle!,
                style: TextStyle(color: Colors.blueGrey),
              ),
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
              return confirmDelete;
            });
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
    return StreamBuilder<String>(
        stream: _authenticationBloc!.User,
        builder: (context, snapshot) {
          if (snapshot.data == 'signed_out') {
            return const Login();
          } else if (_uid == null) {
            return const Login();
          } else {
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
                  preferredSize: const Size.fromHeight(32.00),
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
                          .add('true'); //Add signmout method
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              body: StreamBuilder(
                stream: _homebloc!.listJournal,
                builder: ((BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return _buildListViewSeparated(snapshot);
                  } else {
                    return Center(
                      child: Container(
                        child: const Text("Add jounrals:"),
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  _addOrEditJournal(add: true, journal: Journal(uid: _uid));
                },
                tooltip: 'Add Journal Entry',
                backgroundColor: Colors.lightGreen.shade300,
                child: const Icon(Icons.add),
              ),
            );
          }
        });
  }
}

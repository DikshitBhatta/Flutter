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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthenticationBloc _authenticationBloc;
  Homebloc _homebloc;
  String _uid;
  MoodIcons _moodIcons;
  Formatdates _formatdates;
  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(AuthenticationService());
  }

  @override
  void didChangeDepedencies() {
    super.didChangeDependencies();
    _authenticationBloc =
        AuthenticationBlocProvider().of(context).authenticationBloc;
    _homebloc = Homeblocprovider().of(context).homebloc;
    _uid = Homeblocprovider().of(context).uid;
  }

  @override
  void dispose() {
    _homebloc.dispose();
    super.dispose();
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
              //Add signmout method
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.lightGreen.shade800,
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
        child: Login(),
      )),
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
        onPressed: () {},
        tooltip: 'Add Journal Entry',
        backgroundColor: Colors.lightGreen.shade300,
        child: Icon(Icons.add),
      ),
    );
  }
}

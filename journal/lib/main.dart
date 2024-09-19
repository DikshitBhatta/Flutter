import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:journal/pages/home.dart';
import 'package:journal/blocs/authentication_bloc.dart';
import 'package:journal/blocs/authentication_bloc_provider.dart';
import 'package:journal/blocs/homebloc.dart';
import 'package:journal/blocs/homeblocProvider.dart';
import 'package:journal/services/authentication.dart';
import 'package:journal/services/db_firestore.dart';
import 'package:journal/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationService _authenticationService =
        AuthenticationService();
    final AuthenticationBloc _authenticationBloc =
        AuthenticationBloc(_authenticationService);
    return AuthenticationBlocProvider(
      authenticationBloc: _authenticationBloc,
      child: StreamBuilder(
          initialData: null,
          stream: _authenticationBloc.User,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Colors.lightGreen,
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return Homeblocprovider(
                  child: _buildMaterialApp(Home()),
                  homebloc:
                      Homebloc(_authenticationService, DbFirestoreServices()),
                  uid: snapshot.data);
            } else {
              return _buildMaterialApp(Login());
            }
          }),
    );
  }
}

MaterialApp _buildMaterialApp(Widget homePage) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Journal',
    theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        appBarTheme: AppBarTheme(color: Colors.lightGreen),
        canvasColor: Colors.lightGreen.shade50,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.lightGreen)),
    home: homePage,
  );
}

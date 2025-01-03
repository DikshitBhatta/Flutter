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
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthenticationService authenticationService = AuthenticationService();
    final AuthenticationBloc authenticationBloc =
        AuthenticationBloc(authenticationService);
    return AuthenticationBlocProvider(
      authenticationBloc: authenticationBloc,
      child: SplashScreen(
        authenticationBloc: authenticationBloc,
        authenticationService: authenticationService,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final AuthenticationBloc authenticationBloc;
  final AuthenticationService authenticationService;
  const SplashScreen({
    required this.authenticationBloc,
    required this.authenticationService,
  });
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: null,
        stream: widget.authenticationBloc.User,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('Snapshot Data: ${snapshot.data}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.lightGreen,
              child: const CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data == 'signed_out') {
              return _buildMaterialApp(Login());
            } else {
              return Homeblocprovider(
                  homebloc: Homebloc(
                      widget.authenticationService, DbFirestoreServices()),
                  uid: snapshot.data,
                  child: _buildMaterialApp(Home()));
            }
          } else {
            return _buildMaterialApp(Login());
          }
        });
  }
}

MaterialApp _buildMaterialApp(Widget homePage) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Journal',
    theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        appBarTheme: const AppBarTheme(color: Colors.lightGreen),
        canvasColor: Colors.lightGreen.shade50,
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.lightGreen)),
    home: homePage,
  );
}

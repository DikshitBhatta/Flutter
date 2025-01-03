import 'package:flutter/material.dart';
import 'package:navigator/Pages/about.dart';
import 'package:navigator/Pages/gratitude.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _howareYou;
  void _openpageAbout(
      {required BuildContext context, bool fullscreenDialog = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => About(),
      ),
    );
  }

  void _openPageGratitude(
      {required BuildContext context, bool fullscreenDialog = false}) async {
    final String? gratitudeResponse = await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: fullscreenDialog,
        builder: (Context) => Gratitude(radioGroupvalue: -1),
      ),
    );
    setState(() {
      _howareYou = gratitudeResponse ?? ' ';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Navigator"),
        actions: <Widget>[
          IconButton(
            onPressed: () =>
                _openpageAbout(context: context, fullscreenDialog: true),
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.00),
          child: Text(
            'Gratitude for $_howareYou',
            style: const TextStyle(fontSize: 32.00),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openPageGratitude(context: context),
        tooltip: 'About',
        child: const Icon(Icons.sentiment_satisfied),
      ),
    );
  }
}

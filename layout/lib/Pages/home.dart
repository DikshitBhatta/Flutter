import 'package:flutter/material.dart';
import 'package:layout/widgets/footer.dart';
import 'package:layout/widgets/giftwrapper.dart';
import 'package:layout/widgets/widget_header.dart';
import 'package:layout/widgets/widget_weather.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: const Text('Layout'),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.all(16.00),
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.cloud_done_outlined)))
        ],
      ),
      body: Container(
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(16.00),
          child: Column(
            children: <Widget>[
              WidgetHeader(),
              Divider(),
              WidgetWeather(),
              Divider(),
              Giftwrapper(),
              Divider(),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

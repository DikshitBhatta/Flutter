import 'package:flutter/material.dart';
import 'package:layout/widgets/footer.dart';
import 'package:layout/widgets/giftwrapper.dart';
import 'package:layout/widgets/widget_header.dart';
import 'package:layout/widgets/widget_weather.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        title: Text('Layout'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.all(16.00),
              child: IconButton(
                  onPressed: () {}, icon: Icon(Icons.cloud_done_outlined)))
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.00),
          child: Column(
            children: <Widget>[
              const WidgetHeader(),
              Divider(),
              const WidgetWeather(),
              Divider(),
              const Giftwrapper(),
              Divider(),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

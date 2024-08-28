import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.lightGreen,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          title: Text(
            'Home',
            textAlign: TextAlign.start,
          ),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
          flexibleSpace: SafeArea(
            child: Icon(
              Icons.camera,
              size: 87.00,
              color: Colors.black,
            ),
          ),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(100.00),
              child: Container(
                color: Colors.lightGreen.shade100,
                height: 75.00,
                width: double.infinity,
                child: Center(
                  child: Text('Bottom'),
                ),
              )),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.00),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const Containerwithboxdecoration(),
                ],
              ),
            ),
          ),
        ));
  }
}

class Containerwithboxdecoration extends StatelessWidget {
  const Containerwithboxdecoration({key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 100.00,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100.00),
              bottomRight: Radius.circular(10.00),
            ),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.lightGreen.shade500,
                  Colors.lightBlue.shade800,
                ]),
            boxShadow: [
              BoxShadow(
                color: Colors.red,
                blurRadius: 10.00,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Center(
            child: RichText(
              text: TextSpan(
                  text: 'container', style: TextStyle(fontSize: 20.00)),
            ),
          ),
        ),
      ],
    );
  }
}

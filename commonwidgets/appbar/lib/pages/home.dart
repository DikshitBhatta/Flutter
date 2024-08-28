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
                Divider(),
                const columnexample(),
                Divider(),
                const rowexample(),
                Divider(),
                const columnrownestedexample(),
                TextButton(
                  onPressed: () {},
                  child: Icon(Icons.flag),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.lightBlue),
                  ),
                ),
                Divider(),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.save),
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.lightGreen.shade200)),
                ),
                Divider(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.flight),
                  iconSize: 42.00,
                  color: Colors.pink,
                  tooltip: 'Flight',
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.play_arrow),
        //label: Text('Play'),
        backgroundColor: Colors.lightGreen.shade100,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightGreen.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(Icons.pause),
            Icon(Icons.stop),
            Icon(Icons.access_time),
            Padding(padding: EdgeInsets.all(00.00))
          ],
        ),
      ),
    );
  }
}

class Containerwithboxdecoration extends StatelessWidget {
  const Containerwithboxdecoration({Key? key}) : super(key: key);
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
                text: 'Flutter World',
                style: TextStyle(
                    fontSize: 20.00,
                    color: Colors.deepPurple,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.deepOrangeAccent,
                    decorationStyle: TextDecorationStyle.dotted,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: ' for ',
                  ),
                  TextSpan(
                    text: ' Mobile ',
                    style: TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class columnexample extends StatelessWidget {
  const columnexample({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text('Column 1'),
        Divider(),
        Text('Column 2'),
        Divider(),
        Text('Column 3'),
      ],
    );
  }
}

class rowexample extends StatelessWidget {
  const rowexample({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text('Row 1'),
        Padding(padding: EdgeInsets.all(16.00)),
        Text('Row 2'),
        Padding(padding: EdgeInsets.all(16.00)),
        Text('Row 3'),
      ],
    );
  }
}

class columnrownestedexample extends StatelessWidget {
  const columnrownestedexample({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text('column and row nesting 1'),
        Text('column and row nesting 2'),
        Text('columna and row nesting 3'),
        Padding(padding: EdgeInsets.all(16.00)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Row1'),
            Text('Row 2'),
            Text('Row 3'),
          ],
        ),
      ],
    );
  }
}

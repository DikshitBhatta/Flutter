import 'package:flutter/material.dart';

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
        //backgroundColor: Colors.lightGreen,
        leading: PopupMenuButton<ToDoMenuItem>(
          icon: const Icon(Icons.view_list),
          onSelected: ((valueSelected) {
            print('valueSelected: ${valueSelected.title}');
          }),
          itemBuilder: (BuildContext context) {
            return foodMenuList.map((ToDoMenuItem todoMenuItem) {
              return PopupMenuItem<ToDoMenuItem>(
                value: todoMenuItem,
                child: Row(
                  children: <Widget>[
                    Icon(todoMenuItem.icon?.icon),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Text(todoMenuItem.title!),
                  ],
                ),
              );
            }).toList();
          },
        ),
        title: const Text(
          'Home',
          textAlign: TextAlign.start,
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
        flexibleSpace: const SafeArea(
          child: Icon(
            Icons.camera,
            size: 60.00,
            color: Colors.black,
          ),
        ),
        bottom: const PopupMenuButtonWidget(),
        /*PreferredSize(
          preferredSize: Size.fromHeight(100.00),
          child: Container(
            color: Colors.lightGreen.shade100,
            height: 75.00,
            width: double.infinity,
            child: Center(
              child: Text('Bottom'),
            ),
          ),
        ),*/
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.00),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Containerwithboxdecoration(),
                const Divider(),
                const columnexample(),
                const Divider(),
                const rowexample(),
                const Divider(),
                const columnrownestedexample(),
                TextButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.lightBlue),
                  ),
                  child: Icon(Icons.flag),
                ),
                const Divider(),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.lightGreen.shade200)),
                  child: Icon(Icons.save),
                ),
                const Divider(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.flight),
                  iconSize: 42.00,
                  color: Colors.pink,
                  tooltip: 'Flight',
                ),
                const Divider(),
                Container(
                    color: Colors.amber,
                    child: OverflowBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.map),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.airport_shuttle),
                        ),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.brush)),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        //label: Text('Play'),
        backgroundColor: Colors.lightGreen.shade100,
        child: Icon(Icons.play_arrow),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightGreen.shade100,
        child: const Row(
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
  const Containerwithboxdecoration({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 100.00,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
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
            boxShadow: const [
              BoxShadow(
                color: Colors.red,
                blurRadius: 10.00,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Center(
            child: RichText(
              text: const TextSpan(
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
  const columnexample({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
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
  const rowexample({super.key});
  @override
  Widget build(BuildContext context) {
    return const Row(
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
  const columnrownestedexample({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
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

class ToDoMenuItem {
  final String? title;
  final Icon? icon;
  ToDoMenuItem({this.title, this.icon});
}

List<ToDoMenuItem> foodMenuList = [
  ToDoMenuItem(title: 'Fast food', icon: const Icon(Icons.fastfood)),
  ToDoMenuItem(title: 'Remind me', icon: const Icon(Icons.add_alarm)),
  ToDoMenuItem(title: 'Flight', icon: const Icon(Icons.flight)),
  ToDoMenuItem(title: 'Music', icon: const Icon(Icons.audiotrack)),
];

class PopupMenuButtonWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const PopupMenuButtonWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen.shade100,
      height: preferredSize.height,
      width: double.infinity,
      child: Center(
        child: PopupMenuButton<ToDoMenuItem>(
          icon: const Icon(Icons.view_list),
          onSelected: ((valueSelected) {
            print('valueSelected: ${valueSelected.title}');
          }),
          itemBuilder: (BuildContext context) {
            return foodMenuList.map((ToDoMenuItem todoMenuItem) {
              return PopupMenuItem<ToDoMenuItem>(
                value: todoMenuItem,
                child: Row(
                  children: <Widget>[
                    Icon(todoMenuItem.icon!.icon),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Text(todoMenuItem.title!),
                  ],
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

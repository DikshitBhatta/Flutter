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
              Image(
                image: AssetImage("assets/images/birthday.jpg"),
              ),
              Text(
                'My Birthday',
                style: TextStyle(
                    fontSize: 40.00,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              Divider(),
              Text(
                '''It's going to be great birhtday.
We are going out for dinner at my 
favorite place,then watch a movie after we
go to galeteria for icecream and espresso. ''',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.sunny,
                    color: Colors.amber,
                    weight: 100.00,
                  ),
                  SizedBox(
                    width: 20.00,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '81° Clear',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                      Text(
                        '4500 San Alpho Drive, Dallas, TX United States',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              Wrap(
                children: List.generate(
                  7,
                  (int index) {
                    return Chip(
                      label: Text(
                        "Gift ${index + 1}",
                        style: TextStyle(fontSize: 10.00),
                      ),
                      avatar: Icon(Icons.card_giftcard),
                    );
                  },
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    radius: 40.00,
                    backgroundImage: AssetImage("assets/images/burger.jpg"),
                  ),
                  CircleAvatar(
                    radius: 40.00,
                    backgroundImage: AssetImage("assets/images/melon.jpg"),
                  ),
                  CircleAvatar(
                    radius: 40.00,
                    backgroundImage: AssetImage("assets/images/pasta.jpeg"),
                  ),
                  SizedBox(
                    width: 15.00,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.cake),
                      Icon(Icons.star),
                      Icon(Icons.music_note),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

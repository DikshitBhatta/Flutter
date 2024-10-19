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
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.view_list)),
        title: const Text('ImageExample'),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.notification_add)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.message)),
        ],
        flexibleSpace: const SafeArea(child: Icon(Icons.flag)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Stack(
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/images/photo.jpg"),
                  ),
                  Positioned(
                    top: 0.00,
                    right: 0.00,
                    child: FractionalTranslation(
                      translation: Offset(0.3, -0.3),
                      child: CircleAvatar(
                        radius: 30.00,
                        child: Icon(Icons.star),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.00,
                    left: 0.00,
                    child: Text(
                      'Shree Krishna',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Image.network(
                  'https://img.freepik.com/free-photo/snowy-mountain-peak-starry-galaxy-majesty-generative-ai_188544-9650.jpg?t=st=1724908706~exp=1724912306~hmac=c9f64e6193c137af3bc0bebc8624ccfc7a3c292ed1a0d2975724b433cb85cce4&w=2000'),
              const Divider(),
              ElevatedButton(
                onPressed: () {},
                child: const Icon(Icons.image),
              ),
              const Divider(),
              const ImageandIconWidget(),
              const Divider(),
              //Boxdecoration
              Container(
                height: 100.00,
                width: 100.00,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40.00)),
                    color: Colors.orange,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.00,
                        offset: Offset(0, 10.00),
                      )
                    ]),
              ),
              const Divider(),
              Container(
                child: Column(
                  children: <Widget>[
                    const TextField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.00,
                      ),
                      decoration: InputDecoration(
                        labelText: "Notes",
                        labelStyle: TextStyle(color: Colors.purple),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const Divider(
                      thickness: 0.00,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Enter your notes",
                        border: OutlineInputBorder(),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ImageandIconWidget extends StatelessWidget {
  const ImageandIconWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image(
          image: const AssetImage("assets/images/chicken.jpg"),
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width / 3,
        ),
        Image.network(
          'https://flutter.io/images/catalog­widget­placeholder.png',
          //width: MediaQuery.of(context).size.width / 3,
        ),
        const Icon(
          Icons.brush,
          color: Colors.lightBlue,
          size: 48.00,
        )
      ],
    );
  }
}

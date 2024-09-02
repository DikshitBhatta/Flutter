import 'package:flutter/material.dart';

class WidgetHeader extends StatelessWidget {
  const WidgetHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
        ],
      ),
    );
  }
}

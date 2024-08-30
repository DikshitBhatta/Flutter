import 'package:flutter/material.dart';

class Gratitude extends StatefulWidget {
  final int radioGroupvalue;
  Gratitude({Key? Key, required this.radioGroupvalue}) : super(key: Key);
  @override
  _gratitudeState createState() => _gratitudeState();
}

class _gratitudeState extends State<Gratitude> {
  List<dynamic> gratitudelist = List<String>.empty(growable: true);
  String? _selectedGratitude;
  int? _radioGroupValue;
  void _radioOnChanged(int index) {
    setState(() {
      _radioGroupValue = index;
      _selectedGratitude = gratitudelist[index];
      print('_selectedRadioValue $_selectedGratitude');
    });
  }

  @override
  void initState() {
    super.initState();
    gratitudelist
      ..add('Family')
      ..add('Friends')
      ..add('coffee');
    _radioGroupValue = widget.radioGroupvalue;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gratitude'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context, _selectedGratitude);
            },
            icon: Icon(Icons.check),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.00),
          child: Row(
            children: <Widget>[
              Radio(
                value: 0,
                groupValue: _radioGroupValue,
                onChanged: (index) => _radioOnChanged(index!),
              ),
              Text('Family'),
              Radio(
                value: 1,
                groupValue: _radioGroupValue,
                onChanged: (index) => _radioOnChanged(index!),
              ),
              Text('Friends'),
              Radio(
                  value: 2,
                  groupValue: _radioGroupValue,
                  onChanged: (index) => _radioOnChanged(index!)),
              Text('Coffee'),
            ],
          ),
        ),
      ),
    );
  }
}

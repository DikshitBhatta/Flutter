import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final Order _order = Order();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 40,
                backgroundColor: Colors.yellow)),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Form(
                key: _formStateKey,
                autovalidateMode: AutovalidateMode.always,
                child: Padding(
                  padding: EdgeInsets.all(16.00),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Espresso',
                          labelText: 'Items',
                        ),
                        validator: (value) => _validateItemRequired(value!),
                        onSaved: (value) => _order.item = value,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          hintText: '0-100',
                        ),
                        validator: (value) => _validateItemCount(value!),
                        onSaved: (value) =>
                            _order.quantity = int.tryParse(value!),
                      ),
                      Divider(
                        height: 32.00,
                      ),
                      ElevatedButton(
                        onPressed: () => _submitorder(),
                        child: Text('Save'),
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.lightGreen)),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  String? _validateItemRequired(String value) {
    return value.isEmpty ? 'Item Required' : null;
  }

  String? _validateItemCount(String value) {
    int? _valueAsInt = value.isEmpty ? 0 : int.tryParse(value);
    return _valueAsInt == 0 ? 'At least One Item is required' : null;
  }

  void _submitorder() {
    if (_formStateKey.currentState?.validate() ?? false) {
      _formStateKey.currentState?.save();
      print('Order Item: ${_order.item}');
      print('Order quantity: ${_order.quantity}');
    }
  }
}

class Order {
  String? item;
  int? quantity;
}

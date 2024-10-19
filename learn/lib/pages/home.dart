import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

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
        title: const Text('HOME',
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
                  padding: const EdgeInsets.all(16.00),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Espresso',
                          labelText: 'Items',
                        ),
                        validator: (value) => _validateItemRequired(value!),
                        onSaved: (value) => _order.item = value,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                          hintText: '0-100',
                        ),
                        validator: (value) => _validateItemCount(value!),
                        onSaved: (value) =>
                            _order.quantity = int.tryParse(value!),
                      ),
                      const Divider(
                        height: 32.00,
                      ),
                      ElevatedButton(
                        onPressed: () => _submitorder(),
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.lightGreen)),
                        child: Text('Save'),
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
    int? valueAsInt = value.isEmpty ? 0 : int.tryParse(value);
    return valueAsInt == 0 ? 'At least One Item is required' : null;
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

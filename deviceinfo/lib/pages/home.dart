import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this line to import the platform_channel package

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const _methodchannel =
      MethodChannel('platformchannel.companyname.com/deviceinfo');
  String _deviceinfo = ' ';

  Future<void> _getDeviceInfo() async {
    String deviceinfo;
    try {
      deviceinfo = await _methodchannel.invokeMethod('getDeviceInfo');
    } on PlatformException catch (e) {
      // Use the correct class name 'PlatformException'
      deviceinfo = 'Failed to get device info ${e.message}';
    }
    setState(() {
      _deviceinfo = deviceinfo;
    });
  }

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Info"),
      ),
      body: SafeArea(
        child: ListTile(
          title: const Text(
            'Deviceinfo',
            style: TextStyle(
              fontSize: 24.00,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            _deviceinfo,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          contentPadding: const EdgeInsets.all(16.00),
        ),
      ),
    );
  }
}

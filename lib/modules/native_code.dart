import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeCodeScreen extends StatefulWidget {
  const NativeCodeScreen({super.key});

  @override
  State<NativeCodeScreen> createState() => _NativeCodeScreenState();
}

class _NativeCodeScreenState extends State<NativeCodeScreen> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  // Get battery level.

  String _batteryLevel = 'Unknown battery level.';

  void _getBatteryLevel() {
    platform
        .invokeMethod<int>('getBatteryLevel')
        .then((value)
    {
      setState(() {
        _batteryLevel = 'Battery level $value%';
      });
    })
        .catchError((error) {
          setState(() {
            _batteryLevel = "Failed to get battery level: '${error.message}'.";
          });
    });
  }

  // Future<void> _getBatteryLevel() async {
  //   String batteryLevel;
  //   try {
  //     final result = await platform.invokeMethod<int>('getBatteryLevel');
  //     batteryLevel = 'Battery level $result%';
  //   } on PlatformException catch (e) {
  //     batteryLevel = "Failed to get battery level: '${e.message}'.";
  //   }
  //
  //   setState(() {
  //     _batteryLevel = batteryLevel;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}

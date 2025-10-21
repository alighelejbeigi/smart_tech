// example/lib/main.dart

import 'package:flutter/material.dart';
import 'package:smart_tech/smart_tech.dart'; // import پکیج شما

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Tech Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const SmartTechDemo(),
    );
  }
}

class SmartTechDemo extends StatefulWidget {
  const SmartTechDemo({super.key});

  @override
  State<SmartTechDemo> createState() => _SmartTechDemoState();
}

class _SmartTechDemoState extends State<SmartTechDemo> {
  final _smartTechPlugin = SmartTech(); // ساخت یک instance از کلاس پلاگین
  int? _randomNumber;
  int? _fixedValue;
  String _statusMessage = 'Press the button to load native data.';

  Future<void> _loadNativeData() async {
    setState(() {
      _statusMessage = 'Loading data...';
      _randomNumber = null;
      _fixedValue = null;
    });

    try {
      // فراخوانی متد جدید
      final data = await _smartTechPlugin.getNativeData();

      if (data != null) {
        setState(() {
          _randomNumber = data['randomNumber'];
          _fixedValue = data['fixedValue'];
          _statusMessage = 'Data loaded successfully!';
        });
      } else {
        setState(() {
          _statusMessage = 'Error: Received null data.';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'ERROR: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Method Channel Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _statusMessage,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // نمایش مقدار رندوم
            if (_randomNumber != null) ...[
              const Text(
                'Random Value from Native:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '$_randomNumber',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: Colors.blue),
              ),
            ],

            const SizedBox(height: 20),

            // نمایش مقدار ثابت
            if (_fixedValue != null) ...[
              const Text(
                'Fixed Value (100) from Native:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '$_fixedValue',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: Colors.green),
              ),
            ],

            // نمایش لودینگ
            if (_randomNumber == null && _statusMessage == 'Loading data...')
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator(),
              ),

            const SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadNativeData,
        tooltip: 'Get Native Data',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

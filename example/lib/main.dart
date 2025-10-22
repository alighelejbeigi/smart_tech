import 'package:flutter/material.dart';
import 'package:smart_tech/smart_tech.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Tech Plugin Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const SmartTechDemo(),
    );
  }
}

// کلاس اصلی که منطق UI و State را نگه می‌دارد
class SmartTechDemo extends StatefulWidget {
  const SmartTechDemo({super.key});

  @override
  State<SmartTechDemo> createState() => _SmartTechDemoState();
}

class _SmartTechDemoState extends State<SmartTechDemo> {
  final _smartTechPlugin = SmartTech();

  // متغیر برای نگهداری مقداری که باید در تکست‌باکس نمایش داده شود.
  String _displayValue = 'Ready';
  String _statusMessage = 'برای دریافت داده، روی دکمه‌ها کلیک کنید.';
  bool _isLoading = false;

  // متغیر برای شمارش تعداد دفعات Rebuild (طبق درخواست، مقدار همیشه 1 خواهد بود)
  // اگر این مقدار در build استفاده شود، در هر rebuild دیده می‌شود، اما ما مقدار آن را ثابت نگه می‌داریم.
  final int _rebuildCount = 1;

  // متد برای فراخوانی عدد رندوم از Native
  Future<void> _loadRandomData() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'در حال درخواست عدد تصادفی...';
    });

    try {
      final data = await _smartTechPlugin.getNativeData();
      if (data != null) {
        setState(() {
          _displayValue = data['randomNumber']!.toString();
          _statusMessage = 'عدد تصادفی دریافت شد.';
        });
      } else {
        setState(() {
          _statusMessage = 'خطا: داده‌ای دریافت نشد.';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'خطا در Native: $e';
        _displayValue = 'ERROR';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // متد برای نمایش عدد ثابت 100
  Future<void> _loadFixedData() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'در حال درخواست عدد ثابت...';
    });

    try {
      final data = await _smartTechPlugin.getNativeData();
      if (data != null) {
        setState(() {
          _displayValue = data['fixedValue']!.toString();
          _statusMessage = 'عدد ثابت ۱۰۰ دریافت شد.';
        });
      } else {
        setState(() {
          _statusMessage = 'خطا: داده‌ای دریافت نشد.';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'خطا در Native: $e';
        _displayValue = 'ERROR';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // از آنجایی که متغیر _rebuildCount همیشه 1 است، مقدار آن را ثابت در نظر می‌گیریم.
    // در واقع، هر بار که این متد اجرا می‌شود (Rebuild), مقدار 1 را نمایش می‌دهد.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Data Reader Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ۱. کادر نمایش مقدار (Text Box)
              Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      const Text(
                        'مقدار دریافتی از Native:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (_isLoading)
                        const CircularProgressIndicator()
                      else
                        Text(
                          _displayValue,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge?.copyWith(
                            color:
                                _displayValue == 'Ready' ||
                                        _displayValue == 'ERROR'
                                    ? Colors.grey
                                    : Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(height: 10),
                      Text(
                        _statusMessage,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ۲. دکمه‌ها
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _loadRandomData,
                      icon: const Icon(Icons.casino_outlined),
                      label: const Text('دریافت عدد تصادفی'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _loadFixedData,
                      icon: const Icon(Icons.lock_open),
                      label: const Text('دریافت عدد ثابت (۱۰۰)'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // ۳. باکس شمارنده Rebuild (همیشه 1)
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'تعداد Rebuild (ثابت):',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        // مقدار این متغیر همیشه 1 است و در هر بار rebuild نمایش داده می‌شود.
                        '$_rebuildCount',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineMedium?.copyWith(
                          color: Colors.red.shade900,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

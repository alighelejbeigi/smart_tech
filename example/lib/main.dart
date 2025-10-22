import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DataController());

    return GetMaterialApp(
      title: 'Smart Tech Plugin Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
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
  final DataController controller = Get.find();

  late String _previousDisplayValue;

  @override
  void initState() {
    super.initState();
    _previousDisplayValue = controller.displayValue.value;
  }

  @override
  void didUpdateWidget(covariant SmartTechDemo oldWidget) {
    super.didUpdateWidget(oldWidget);

    final currentDisplayValue = controller.displayValue.value;

    if (_previousDisplayValue != currentDisplayValue) {
      controller.rebuildCount.value++;
    }

    _previousDisplayValue = currentDisplayValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Data Reader Demo (GetX)'),
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
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const CircularProgressIndicator();
                        } else {
                          return Text(
                            controller.displayValue.value,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineLarge?.copyWith(
                              color:
                                  controller.displayValue.value == 'Ready' ||
                                          controller.displayValue.value ==
                                              'ERROR'
                                      ? Colors.grey
                                      : Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      }),
                      const SizedBox(height: 10),
                      Obx(
                        () => Text(
                          controller.statusMessage.value,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed:
                            controller.isLoading.value
                                ? null
                                : controller.loadRandomData,
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
                        onPressed:
                            controller.isLoading.value
                                ? null
                                : controller.loadFixedData,
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
              ),

              const SizedBox(height: 40),

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
                        'تعداد به‌روزرسانی حالت:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.rebuildCount.value.toString(),
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium?.copyWith(
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.w800,
                          ),
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

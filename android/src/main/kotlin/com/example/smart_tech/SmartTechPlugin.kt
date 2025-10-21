package com.example.smart_tech

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlin.random.Random

/** SmartTechPlugin */
class SmartTechPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "smart_tech")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")

    } else if (call.method == "get_random_and_fixed") { // هندل کردن متد جدید

      // ۱. تولید داده تصادفی
      val randomNumber = Random.nextInt(1, 1000) // تولید عدد بین ۱ تا ۱۰۰۰

      // ۲. تعریف مقدار دقیق (ثابت)
      val fixedValue = 100

      // ۳. ساخت Map برای ارسال به Flutter
      val data = mapOf(
        "randomNumber" to randomNumber,
        "fixedValue" to fixedValue
      )

      // ارسال موفقیت‌آمیز نتیجه (Map) به Flutter
      result.success(data)

    } else {
      result.notImplemented()
    }
  }
}

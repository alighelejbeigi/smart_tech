package com.example.smart_tech

import androidx.annotation.NonNull // برای پارامترهای @NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler // نگه داشتن این برای پیاده‌سازی اینترفیس
import kotlin.random.Random
// <--- خطوط import تکراری (مثل .Result) حذف شدند --->

/** SmartTechPlugin */
class SmartTechPlugin: FlutterPlugin, MethodCallHandler {

  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "smart_tech")
    // ارجاع به کلاس فعلی (This) که MethodCallHandler را پیاده‌سازی می‌کند
    channel.setMethodCallHandler(this)
  }

  // <--- متد onMethodCall اصلی و واحد (متد تکراری حذف شد) --->
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        // متد اول: نمایش نسخه اندروید
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "get_random_and_fixed" -> {
        // متد دوم: منطق تولید دو عدد
        val randomNumber = Random.nextInt(1, 1000)
        val fixedValue = 100

        val data = mapOf(
          "randomNumber" to randomNumber,
          "fixedValue" to fixedValue
        )

        result.success(data)
      }
      else -> {
        // اگر متد ناشناخته بود
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
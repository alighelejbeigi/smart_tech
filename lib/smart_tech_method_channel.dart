import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'smart_tech_platform_interface.dart';

/// An implementation of [SmartTechPlatform] that uses method channels.
class MethodChannelSmartTech extends SmartTechPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('smart_tech');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<Map<String, int>?> getNativeData() async {
    try {
      // فراخوانی متد مورد نظر در Native
      final Map<dynamic, dynamic>? result = await methodChannel.invokeMethod(
        'get_random_and_fixed',
      );

      if (result != null) {
        // تبدیل Map دریافتی به فرمت مورد انتظار
        return {
          'randomNumber': result['randomNumber'] as int,
          'fixedValue': result['fixedValue'] as int,
        };
      }
      return null;
    } on PlatformException catch (e) {
      // مدیریت خطا (مثل MissingPluginException)
      debugPrint("Failed to get data from native: ${e.message}");
      rethrow;
    }
  }
}

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
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

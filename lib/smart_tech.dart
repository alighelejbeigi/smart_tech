// lib/smart_tech.dart

import 'smart_tech_platform_interface.dart';

class SmartTech {
  static SmartTechPlatform get _platform => SmartTechPlatform.instance;

  Future<String?> getPlatformVersion() {
    return _platform.getPlatformVersion();
  }

  Future<Map<String, int>?> getNativeData() {
    return _platform.getNativeData();
  }
}

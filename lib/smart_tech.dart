// lib/smart_tech.dart

import 'smart_tech_platform_interface.dart';

class SmartTech {
  // این کد از قبل در فایل شما موجود است
  static SmartTechPlatform get _platform => SmartTechPlatform.instance;

  // متد موجود:
  Future<String?> getPlatformVersion() {
    return _platform.getPlatformVersion();
  }

  // >>> متد جدیدی که باید اضافه شود:
  Future<Map<String, int>?> getNativeData() {
    return _platform.getNativeData();
  }
}

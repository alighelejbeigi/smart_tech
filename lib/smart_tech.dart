
import 'smart_tech_platform_interface.dart';

class SmartTech {
  Future<String?> getPlatformVersion() {
    return SmartTechPlatform.instance.getPlatformVersion();
  }
}

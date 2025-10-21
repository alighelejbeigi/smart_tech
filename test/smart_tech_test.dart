import 'package:flutter_test/flutter_test.dart';
import 'package:smart_tech/smart_tech.dart';
import 'package:smart_tech/smart_tech_platform_interface.dart';
import 'package:smart_tech/smart_tech_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSmartTechPlatform
    with MockPlatformInterfaceMixin
    implements SmartTechPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SmartTechPlatform initialPlatform = SmartTechPlatform.instance;

  test('$MethodChannelSmartTech is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSmartTech>());
  });

  test('getPlatformVersion', () async {
    SmartTech smartTechPlugin = SmartTech();
    MockSmartTechPlatform fakePlatform = MockSmartTechPlatform();
    SmartTechPlatform.instance = fakePlatform;

    expect(await smartTechPlugin.getPlatformVersion(), '42');
  });
}

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'smart_tech_method_channel.dart';

abstract class SmartTechPlatform extends PlatformInterface {
  /// Constructs a SmartTechPlatform.
  SmartTechPlatform() : super(token: _token);

  static final Object _token = Object();

  static SmartTechPlatform _instance = MethodChannelSmartTech();

  /// The default instance of [SmartTechPlatform] to use.
  ///
  /// Defaults to [MethodChannelSmartTech].
  static SmartTechPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SmartTechPlatform] when
  /// they register themselves.
  static set instance(SmartTechPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

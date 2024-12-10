import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'speedpay_sdk_plugin_method_channel.dart';

abstract class SpeedpaySdkPluginPlatform extends PlatformInterface {
  /// Constructs a SpeedpaySdkPluginPlatform.
  SpeedpaySdkPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static SpeedpaySdkPluginPlatform _instance = MethodChannelSpeedpaySdkPlugin();

  /// The default instance of [SpeedpaySdkPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelSpeedpaySdkPlugin].
  static SpeedpaySdkPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SpeedpaySdkPluginPlatform] when
  /// they register themselves.
  static set instance(SpeedpaySdkPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> payOrder(Map<String, dynamic> params) {
    throw UnimplementedError('payOrder() has not been implemented.');
  }
}

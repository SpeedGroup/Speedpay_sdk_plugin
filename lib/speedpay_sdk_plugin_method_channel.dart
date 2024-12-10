import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'speedpay_sdk_plugin_platform_interface.dart';

/// An implementation of [SpeedpaySdkPluginPlatform] that uses method channels.
class MethodChannelSpeedpaySdkPlugin extends SpeedpaySdkPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('speedpay_sdk_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> payOrder(Map<String, dynamic> params) async {
    final result = await methodChannel.invokeMethod('payOrder', params);
    return result;
  }
}

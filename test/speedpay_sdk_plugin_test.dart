import 'package:flutter_test/flutter_test.dart';
import 'package:speedpay_sdk_plugin/speedpay_sdk_plugin.dart';
import 'package:speedpay_sdk_plugin/speedpay_sdk_plugin_platform_interface.dart';
import 'package:speedpay_sdk_plugin/speedpay_sdk_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSpeedpaySdkPluginPlatform
    with MockPlatformInterfaceMixin
    implements SpeedpaySdkPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> payOrder(Map<String, dynamic> params) {
    // TODO: implement payOrder
    throw UnimplementedError();
  }
}

void main() {
  final SpeedpaySdkPluginPlatform initialPlatform = SpeedpaySdkPluginPlatform.instance;

  test('$MethodChannelSpeedpaySdkPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSpeedpaySdkPlugin>());
  });

  test('getPlatformVersion', () async {
    SpeedpaySdkPlugin speedpaySdkPlugin = SpeedpaySdkPlugin();
    MockSpeedpaySdkPluginPlatform fakePlatform = MockSpeedpaySdkPluginPlatform();
    SpeedpaySdkPluginPlatform.instance = fakePlatform;

    expect(await speedpaySdkPlugin.getPlatformVersion(), '42');
  });
}

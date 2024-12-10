
import 'speedpay_sdk_plugin_platform_interface.dart';

class SpeedpaySdkPlugin {
  Future<String?> getPlatformVersion() {
    return SpeedpaySdkPluginPlatform.instance.getPlatformVersion();
  }

  Future<String?> payOrder(Map<String, dynamic> params) async {
    return SpeedpaySdkPluginPlatform.instance.payOrder(params);
  }
}

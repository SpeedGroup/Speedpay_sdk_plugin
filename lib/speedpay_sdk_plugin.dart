
import 'dart:async';

import 'package:flutter/services.dart';

class SpeedpaySdkPlugin {
  static const MethodChannel _channel = MethodChannel('speedpay_sdk_plugin');

  static Future<String?> payOrder(Map<String, dynamic> params) async {
    final String? version = await _channel.invokeMethod('payOrder', params);
    return version;
  }
}

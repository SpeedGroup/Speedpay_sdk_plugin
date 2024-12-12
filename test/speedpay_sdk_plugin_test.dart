import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speedpay_sdk_plugin/speedpay_sdk_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('speedpay_sdk_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await SpeedpaySdkPlugin.platformVersion, '42');
  });
}

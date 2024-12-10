import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:speedpay_sdk_plugin/speedpay_sdk_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _speedpaySdkPlugin = SpeedpaySdkPlugin();
  final dio = Dio();

  final appId = "SP6562704777";
  final mchId = "9931386389";
  final secret = "337fb22082104216a30bc929c31735dc";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SpeedPay SDK Plugin example app'),
        ),
        body: Center(
          child: FilledButton(onPressed: _createOrder, child: const Text("使用SpeedPay支付")),
        ),
      ),
    );
  }

  Future<void> _createOrder() async {
    // 商品标题
    String subject = "iphone15";
    // 商户订单号（此处用时间戳代替，实际应替换为真实数据）
    String outTradeNo = (DateTime.now().millisecondsSinceEpoch).toString();
    // 通知地址（实际应替换为真实数据）
    String notifyUrl = "https://wwww.baidu.com";
    // 订单总金额（实际应替换为真实数据）
    int amount = 100;
    // 货币类型
    String currency = "hkd";

    // 创建参数
    Map<String, dynamic> parameters = {
      "appid": appId,
      "mchid": mchId,
      "subject": subject,
      "out_trade_no": outTradeNo,
      "notify_url": notifyUrl,
      "amount": amount,
      "currency": currency,
      "nonce_str": "asdfasdfa" // 随机字符串
    };

    // 添加签名（这里使用的是假的签名函数，需要替换）
    parameters["sign"] = _sign(parameters);
    debugPrint("parameters:${parameters}");
    // 发起网络请求
    try {
      var dio = Dio();
      var response = await dio.post("https://speedpay.hk/api/pay_server/v1/transactions/app",
          data: parameters,
          options: Options(
            contentType: Headers.jsonContentType, // 注意：这里可能需要调整为application/json，取决于API的要求
          ));
      debugPrint("data:${response.data}");
      // 解析响应
      if (response.statusCode == 200) {
        var data = response.data;
        if (data is Map && data.containsKey("result")) {
          var result = data["result"] as Map;
          if (result.containsKey("prepay_id")) {
            String prepayId = result["prepay_id"] as String;
           _payOrder(prepayId);
          }
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Request error: $e");
    }
  }
  _payOrder(String prepayId) async {
    try {
      Map<String, dynamic> parameters = {
        "appid": appId,
        "partnerid": mchId,
        "prepayid": prepayId,
        "package": "Sign=Pay", // 固定传值
        "nonce_str": "1234567890", // 随机字符串
        "timestamp": (DateTime.now().millisecondsSinceEpoch).toString() // 时间戳
      };
      parameters["sign"] = _sign(parameters);

      var resultCode = await _speedpaySdkPlugin.payOrder(parameters);
      if (resultCode?.toUpperCase() == "SUCCESS") {
        debugPrint("支付成功!");
      } else if (resultCode?.toUpperCase() == "USER_CANCEL") {
        debugPrint("用户取消!");
      } else {
        debugPrint("其他结果：$resultCode");
      }
    } on PlatformException {
      debugPrint('支付异常');
    }
  }

  // 签名函数
  String _sign(Map<String, dynamic> parameters) {
    // 将参数映射为"key=value"格式的字符串列表
    List<String> parameterStrings = parameters.entries.map((entry) {
      return "${entry.key}=${entry.value?.toString() ?? ''}";
    }).toList();
    // 对字符串列表进行排序（按字典顺序）
    parameterStrings.sort();
    // 将排序后的字符串列表拼接成一个单一的查询字符串
    String stringA = parameterStrings.join('&');
    // 添加密钥到查询字符串末尾
    String stringSignTemp = "${stringA}&key=${secret}";
    print("[stringSignTemp]: $stringSignTemp");

    // 计算SHA-256哈希值并转换为大写十六进制字符串
    List<int> bytes = utf8.encode(stringSignTemp);
    var digest = sha256.convert(bytes);
    var sign = digest.toString().toUpperCase();
    print("[sign]: $sign");

    return sign;
  }
}

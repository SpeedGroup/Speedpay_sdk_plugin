package hk.speedpay.speedpay_sdk_plugin

import android.app.Activity
import android.content.Context
import com.speedpay.pay.SpeedPay
import io.flutter.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** SpeedpaySdkPlugin */
class SpeedpaySdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var applicationContext: Context
  private var activity: Activity? = null
  private var mSpeedPay : SpeedPay? = null
  private var result: Result? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "speedpay_sdk_plugin")
    channel.setMethodCallHandler(this)
    applicationContext = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "payOrder") {
      this.result = null
      var params = call.arguments as HashMap<String, Any>
      if (params != null && activity != null) {
        println(activity)
        this.result = result
        mSpeedPay = SpeedPay(activity!!)
        mSpeedPay?.register { msg ->
          if (result != null) {
            this.result?.success(msg);
            this.result = null
          }
        }
        mSpeedPay?.pay(params)
      } else {
        result.success("PARAM_ERROR")
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    mSpeedPay?.unRegister()
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity;
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }
}

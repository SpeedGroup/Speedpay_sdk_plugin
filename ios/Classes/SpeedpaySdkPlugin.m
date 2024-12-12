#import "SpeedpaySdkPlugin.h"
#import <SpeedPaySDK/SpeedPaySDK.h>

@implementation SpeedpaySdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"speedpay_sdk_plugin"
            binaryMessenger:[registrar messenger]];
  SpeedpaySdkPlugin* instance = [[SpeedpaySdkPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"payOrder" isEqualToString:call.method]) {
        if ([call.arguments isKindOfClass:[NSDictionary class]]) {
            [SpeedPay payOrderWithRequestParams:call.arguments callback:^(NSString * _Nonnull returnCode) {
                result(returnCode);
            }];
        } else {
            result(@"PARAM_ERROR");
        }
    } else {
        result(FlutterMethodNotImplemented);
    }
}

#pragma mark - <AppDelegate>

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [SpeedPay handleOpenURL:url];
}

@end

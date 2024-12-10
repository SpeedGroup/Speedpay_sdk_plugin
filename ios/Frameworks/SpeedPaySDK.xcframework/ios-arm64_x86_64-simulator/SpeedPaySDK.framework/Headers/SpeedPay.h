//
//  SpeedPay.h
//  SpeedPaySDK
//
//  Created by xmy on 2024/3/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SPCompletionBlock)(NSString *returnCode);

/**
 PARAM_ERROR    参数错误    参数格式有误或者未按规则上传    请确认参数问题
 PAY_FAILURE    支付失败    更新订单出错
 SIGN_ERROR    签名错误    参数签名结果不正确    请检查签名参数和方法是否都符合签名算法要求
 SYSTEM_ERROR    系统错误    数据库连接错误等    系统异常，请用相同参数重新调用
 PAY_HAVE_EXPIRED    支付订单过期    已超过支付设定时间    重新支付
 PAY_CARD_BALANCE_INSUFFICIENT    支付卡金额不足    支付卡的金额不够    换卡或充值
 TRANSACTION_ID_NOT_EXISTS    支付订单不存在    错误的支付订单    检查传入的订单是否正确或者被篡改
 SMS_CODE_INCORRECT    短信验证码错误    短信验证码输入错误或乱输    输入正确的短信验证码
 PAY_MONEY_ERROR    付款金额错误    汇率错误或传入小于等于0    检查汇率或输入正确的金额
 */

@interface SpeedPay : NSObject

/// 唤起SpeedPayApp支付订单
/// - Parameters:
///   - requestParams: 支付请求参数
///   - callback: 结果回调
+ (void)payOrderWithRequestParams:(NSDictionary *)requestParams callback:(SPCompletionBlock)callback;

/// 处理SpeedPayApp通过URL回调时传递的数据（需要在application:openURL:(NSURL *)urloptions:中调用）
/// - Parameter url: SpeedPayApp启动第三方应用时传递过来的URL
+ (BOOL)handleOpenURL:(NSURL *)url;

/// SpeedPayApp是否安装
+ (BOOL)isSpeedPayAppInstalled;

/// SDK版本号
+ (NSString *)getSDKVersion;

@end

NS_ASSUME_NONNULL_END

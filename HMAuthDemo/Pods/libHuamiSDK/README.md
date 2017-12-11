# HMiOSAuthSDK
# 华米官方授权SDK
# 环境配置文档链接地址：https://github.com/huamitech/rest-api/wiki/SDK-for-iOS
# Feature
  ## 2017-08-29 tag 1.0.1 demo支持手表助手授权
  ## 2017-12-11 tag 1.1.0 SDK支持不同的App使用相同的APPID，注册API变更，需要做响应改动
# API介绍
<pre><code>
/**
 华米授权策略

 - HMApiAuthPolicyHealthOnly:   只用华米健康
 - HMApiAuthPolicyMiFitOnly:    只用小米运动
 - HMApiAuthPolicyWatchOnly:    只用手表助手
 - HMApiAuthPolicyHealthFirst:  优先使用华米健康(在华米健康不可用的情况下会选择其他可支持授权的应用)
 - HMApiAuthPolicyMiFitFirst:   优先使用小米运动(在小米运动不可用的情况下会选择其他可支持授权的应用)
 - HMApiAuthPolicyWatchFirst:   优先使用手表助手(在手表助手不可用的情况下会选择其他可支持授权的应用)
 */
typedef NS_ENUM(NSUInteger, HMApiAuthPolicy) {
    HMApiAuthPolicyHealthOnly         = 0,
    HMApiAuthPolicyMiFitOnly          = 1,
    HMApiAuthPolicyWatchOnly          = 2,
    HMApiAuthPolicyHealthFirst        = 3,
    HMApiAuthPolicyMiFitFirst         = 4,
    HMApiAuthPolicyWatchFirst         = 5,
};

/**
 接收并处理来自华米应用终端程序的事件消息
 
 接收并处理来自华米应用终端程序的事件消息，期间华米应用界面会切换到第三方应用程序。HMApiDelegate会在handleOpenURL:delegate:中使用并触发。
 */
@protocol HMApiDelegate <NSObject>

@optional

/**
 发送一个sendRequest后，收到华米应用的回应
 
 收到一个来自华米应用的处理结果，调用一次sendRequest后会收到hmApiDelegateDidReceiveResponse。
 可能收到的处理结果有HMSendAuthResponse等。

 @param response 具体回应内容
 */
- (void)hmApiDelegateDidReceiveResponse:(HMBaseResponse *)response;

@end

/**
 华米Api接口函数类，该类封装了华米应用端SDK的所有接口
 */
@interface HMApi : NSObject

/**
 向华米应用注册第三方应用,不进行加密,【推荐】

 需要在每次启动第三方应用程序时调用
 @param authPolicy 授权策略
 @return 成功返回YES，失败返回NO。
 */
+ (BOOL)registerAppWithAuthPolicy:(HMApiAuthPolicy)authPolicy;


/**
 向华米应用注册第三方应用,不进行加密
 
 需要在每次启动第三方应用程序时调用
 @param authPolicy 授权策略
 @param encrypted 是否采用加密，YES 则授权成功后的token信息会加密
 @return 成功返回YES，失败返回NO。
 */
+ (BOOL)registerAppWithAuthPolicy:(HMApiAuthPolicy)authPolicy encrypted:(BOOL)encrypted;

/**
 处理华米应用通过URL启动App时传递的数据
 
 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
 @param url 华米应用启动第三方应用时传递过来的URL
 @param delegate HMApiDelegate对象，用来接收微信触发的消息。
 @return 成功返回YES，失败返回NO。
 */
+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id<HMApiDelegate>)delegate;

/**
 检查华米应用是否安装。

 @return 已安装返回YES，未安装返回NO。
 */
+ (BOOL)isAppInstalled;

/**
 判断当前华米应用的版本是否支持OpenApi

 @return 支持返回YES，不支持返回NO。
 */
+ (BOOL)isAppSupportApi;

/**
 获取华米应用的itunes安装地址

 @return 华米应用的安装地址字符串。
 */
+ (NSString *)getAppInstallUrl;

/**
 获取当前授权SDK的版本号

 @return 返回当前授权SDK的版本号
 */
+ (NSString *)getApiVersion;

/**
 打开华米应用，异步操作

 @param completion 回调，在主线程
 */
+ (void)openAppCompletionHandler:(void (^)(BOOL success))completion;

/**
 发送请求到华米应用，等待华米应用返回hmApiDelegateDidReceiveResponse。

 函数调用后会切换到华米应用的界面，第三方应用程序等待华米应用返回hmApiDelegateDidReceiveResponse，华米应用在异步处理完成后一定会调用hmApiDelegateDidReceiveResponse。支持类型：HMSendAuthRequest
 @param request 具体的发送请求
 @return 成功返回YES，失败返回NO。
 */
+ (BOOL)sendRequest:(HMBaseRequest *)request;
</code></pre>

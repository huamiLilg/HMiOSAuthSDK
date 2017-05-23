//
//  HMApiObject.h
//  HuamiAuthSDK
//
//  Created by 李林刚 on 2017/4/24.
//  Copyright © 2017年 huami. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 错误码

 - HMApiSuccess:            成功
 - HMApiErrCodeUserCancel:  用户点击取消并返回
 - HMApiErrCodeAuthDeny:    授权失败
 - HMApiErrCodeSentFail:    发送失败
 */
typedef NS_ENUM(NSInteger, HMApiErrorCode) {
    HMApiSuccess           = 0,
    HMApiErrCodeUserCancel = -1,
    HMApiErrCodeAuthDeny   = -2,
    HMApiErrCodeSentFail   = -3,
};

/**
 华米应用支持的请求类型
 
 - HMAppRequestTypeAuth: auth授权
 */
typedef NS_ENUM(NSUInteger, HMAppRequestType) {
    HMAppRequestTypeAuth        = 0,
};

/**
 该类为华米应用终端SDK所有请求的基础类
 */
@interface HMBaseRequest : NSObject

/**
 请求的类型，子类定义
 */
@property (readonly) HMAppRequestType type;

/**
 三方唯一Id，有服务端分配，一定不为nil
 */
@property (nonatomic, copy) NSString *appId;

/**
 当前应用的bundleId
 */
@property (nonatomic, copy) NSString *bundleId;

/**
 第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由华米应用终端回传,可不传
 */
@property (nonatomic, copy) NSString *identifying;

@end


/**
 该类为华米应用终端SDK所有响应的基础类
 */
@interface HMBaseResponse : NSObject

/**
 请求的类型，子类定义
 */
@property (nonatomic, assign) HMAppRequestType type;

/**
 错误码
 */
@property (nonatomic, assign) HMApiErrorCode errorCode;

/**
 具体的错误码
 */
@property (nonatomic, assign) NSInteger detailCode;

/**
 错误提示字符串
 */
@property (nonatomic, copy) NSString *errorMessage;

/**
 第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由华米应用终端回传,可不传
 */
@property (nonatomic, copy) NSString *identifying;

@end


@interface HMSendAuthRequest : HMBaseRequest

@end

@interface HMSendAuthResponse : HMBaseResponse

/**
 认证口令
 */
@property (nonatomic, copy) NSString *accessToken;

/**
 认证过期时间
 */
@property (nonatomic, assign) int64_t expiresIn;

/**
 当认证口令过期时用于换取认证口令的更新口令
 */
@property (nonatomic, copy) NSString *refreshToken;

/**
 口令类型
 */
@property (nonatomic, copy) NSString *tokenType;

@end

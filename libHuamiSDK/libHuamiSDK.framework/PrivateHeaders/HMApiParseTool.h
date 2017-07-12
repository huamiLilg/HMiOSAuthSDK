//
//  HMApiParseTool.h
//  HuamiAuthSDK
//
//  Created by 李林刚 on 2017/4/24.
//  Copyright © 2017年 huami. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMBaseRequest;
@class HMBaseResponse;


typedef  void (^HMApiParseToolQueryHandler)(NSString *query);

@interface HMApiParseTool : NSObject

/**
 将请求Model转换为Query
 
 @param request HMBaseRequest
 @param encrypted 是否允许加密
 @param handler 组装回调
 @return YES-组装成功
 */
+ (BOOL)queryWithRequest:(HMBaseRequest *)request encrypted:(BOOL)encrypted handler:(HMApiParseToolQueryHandler)handler;
    
/**
 将从华米健康返回的query转换为HMBaseResponse子类

 @param query NSString
 @return HMBaseResponse子类
 */
+ (HMBaseResponse *)responseWithQuery:(NSString *)query;

@end

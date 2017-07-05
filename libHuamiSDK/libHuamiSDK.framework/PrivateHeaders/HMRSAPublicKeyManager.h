//
//  HMRSAPublicKeyManager.h
//  HMAuthPartnerDemo
//
//  Created by 李林刚 on 2017/7/5.
//  Copyright © 2017年 huami. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  void (^HMRSADownloadCompletionHandler)(NSString *publicKey, NSError *error);

/**
 获取RSA的Publickey
 */
@interface HMRSAPublicKeyManager : NSObject

+ (HMRSAPublicKeyManager *)sharedInstance;

- (void)downloadCompletionHandler:(HMRSADownloadCompletionHandler)completionHandler;


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
@end

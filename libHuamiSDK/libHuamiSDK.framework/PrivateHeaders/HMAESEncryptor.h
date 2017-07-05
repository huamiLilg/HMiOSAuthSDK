//
//  HMAESEncryptor.h
//  HMAuthPartnerDemo
//
//  Created by 李林刚 on 2017/7/3.
//  Copyright © 2017年 huami. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 AES加密类，目前只支持256位加密
 */
@interface HMAESEncryptor : NSObject

/**
 32位随机秘钥,每次app打开都不会重复
 */
+ (NSString *)random32bitsKey;

/**
 加密数据
 
 @param content 明文
 @param key 秘钥
 @return base64密文
 */
+ (NSString *)aesEncryptString:(NSString *)content key:(NSString *)key;

/**
 解密数据
 
 @param content base64密文
 @param key 秘钥
 @return 明文
 */
+ (NSString *)aesDecryptString:(NSString *)content key:(NSString *)key;

@end

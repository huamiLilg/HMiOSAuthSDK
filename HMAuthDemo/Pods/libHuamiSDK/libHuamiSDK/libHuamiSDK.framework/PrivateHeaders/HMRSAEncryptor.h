//
//  HMRSAEncryptor.h
//  HMAuthPartnerDemo
//
//  Created by 李林刚 on 2017/7/3.
//  Copyright © 2017年 huami. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 实现了RSA加密解密方法
 RSA使用"秘匙对"对数据进行加密解密.在加密解密数据前,需要先生成公钥(public key)和私钥(private key).
 公钥(public key): 用于加密数据. 用于公开, 一般存放在数据提供方 .der
 私钥(private key): 用于解密数据. 必须保密, 私钥泄露会造成安全问题 .p12
 */
@interface HMRSAEncryptor : NSObject

/*These APIs uesd to encrypt/decrypt data/string by pulick/private string.
 Sometimes we need to encrypt issue with string keys which wo get from web sercives.
 The goverment doesn't provide api which is able to encrypt/decrypt issue without certificate.
 
 The APIs fudges certificates use the pramaters 'str'.
 
 下面的api直接使用公私钥的字符串进行RSA加密。由于官方没有直接提供对应的api，所以这里使用公私钥字符串来伪造证书进行加密。
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;

/*These APIs uesd to encrypt/decrypt data/string by pulick/private certificate
 The public key should be suffixal with .der and private key with .p12
 The original code https://github.com/baight/RSAEncryptor/blob/master/RSAEncryptor.m .
 I found that the decrypt mothed was wrong when data's length is longer than 128(the accurate value depends on the length of the keys.When the length of keys is 2048,it is 2048/8=256)
 I modified the code to make it run correctly.
 使用公私钥文件进行RSA加密
 代码来源 https://github.com/baight/RSAEncryptor/blob/master/RSAEncryptor.m ,之所以上传这个库,因为我发现原本的代码在解密时时错误的，它只在解密文件很小（小于秘钥长度／8）才能正常工作。我更改了代码,让它可以正常工作
 */
- (void)loadPublicKeyFromFile:(NSString*)derFilePath;
- (void)loadPublicKeyFromData:(NSData*)derData;

- (void)loadPrivateKeyFromFile:(NSString*)p12FilePath password:(NSString*)p12Password;
- (void)loadPrivateKeyFromData:(NSData*)p12Data password:(NSString*)p12Password;

- (NSString*)rsaEncryptString:(NSString*)string;
- (NSData*)rsaEncryptData:(NSData*)data ;

- (NSString*)rsaDecryptString:(NSString *)string;
- (NSData*)rsaDecryptData:(NSData *)data;

@end

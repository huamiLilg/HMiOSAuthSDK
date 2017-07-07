//
//  NSString+HMApi.h
//  HuamiAuthSDK
//
//  Created by 李林刚 on 2017/4/24.
//  Copyright © 2017年 huami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HMApi)

/**
 判断字符串是不是空

 @param string NSString
 @return YES ？ 是 ： 不是空字符串
 */
+ (BOOL)hmapi_isEmpty:(NSString *)string;

@end

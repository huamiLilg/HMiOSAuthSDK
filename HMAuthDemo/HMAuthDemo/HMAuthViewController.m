//
//  HMAuthViewController.m
//  HMAuthPartnerDemo
//
//  Created by 李林刚 on 2017/4/24.
//  Copyright © 2017年 huami. All rights reserved.
//

#import "HMAuthViewController.h"
#import <libHuamiSDK/HMApi.h>

@interface HMAuthViewController ()

@end

@implementation HMAuthViewController

#pragma mark - ButtonAction

- (IBAction)checkButtonAction:(id)sender {
   BOOL isInstall = [HMApi isAppInstalled];
    if (isInstall) {
        [self showAlertTitle:@"已安装华米应用" message:nil];
    }
}

- (IBAction)openButtonAction:(id)sender {
    if ([HMApi isAppInstalled]) {
        //是否安装对应的应用，一定要使用SDK提供的API。安装不一定支持授权
        [HMApi openAppCompletionHandler:^(BOOL success) {
            
        }];
    }
}

- (IBAction)authButtonAction:(id)sender {
    if ([HMApi isAppSupportApi]) {
        //是否支持授权，一定要使用SDK提供的API。支持授权的一定已经安装了
        HMSendAuthRequest *authRequest = [[HMSendAuthRequest alloc] init];
        [HMApi sendRequest:authRequest];
    } else {
        [self showAlertTitle:@"不支持授权" message:@"在调用也没用"];
    }
}

#pragma mark - Private Methods

- (void)showAlertTitle:(NSString *)title message:(NSString *)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end

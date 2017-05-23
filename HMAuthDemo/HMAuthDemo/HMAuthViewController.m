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
    [HMApi openAppCompletionHandler:^(BOOL success) {
        if (!success) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"打开失败" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

- (IBAction)authButtonAction:(id)sender {
    self.authInfoTextView.text = @"";
    HMSendAuthRequest *authRequest = [[HMSendAuthRequest alloc] init];
    [HMApi sendRequest:authRequest];
}

#pragma mark - Private Methods

- (void)showAlertTitle:(NSString *)title message:(NSString *)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end

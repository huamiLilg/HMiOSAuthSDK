//
//  AppDelegate.m
//  HMAuthDemo
//
//  Created by 李林刚 on 2017/5/23.
//  Copyright © 2017年 huami. All rights reserved.
//

#import "AppDelegate.h"
#import "HMAuthViewController.h"

#import <libHuamiSDK/HMApi.h>

@interface AppDelegate ()<HMApiDelegate>

@property (nonatomic, strong) HMAuthViewController *controller;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [HMApi registerAppWithAuthPolicy:HMApiAuthPolicyMiFitFirst];

    HMAuthViewController *viewController = [[HMAuthViewController alloc] init];
    self.controller = viewController;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    return [HMApi handleOpenURL:url delegate:self];
}

#pragma mark - HMApiDelegate

- (void)hmApiDelegateDidReceiveResponse:(HMBaseResponse *)response{
    if (response.errorCode == HMApiSuccess) {
        if (response.type == HMAppRequestTypeAuth) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"授权成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
            
            HMSendAuthResponse *authResponse = (HMSendAuthResponse *)response;
            NSString *string = [NSString stringWithFormat:@"accessToken = %@\nexpiresIn=%lld\nrefreshToken=%@\ntokenType=%@\n",authResponse.accessToken,authResponse.expiresIn,authResponse.refreshToken,authResponse.tokenType];
            self.controller.authInfoTextView.text = string;
        }
    } else if (response.errorCode == HMApiErrCodeUserCancel){
        if (response.type == HMAppRequestTypeAuth) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"取消授权" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
    } else if (response.errorCode == HMApiErrCodeAuthDeny){
        if (response.type == HMAppRequestTypeAuth) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"授权失败" message:response.errorMessage preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
            
            HMSendAuthResponse *authResponse = (HMSendAuthResponse *)response;
            NSString *string = [NSString stringWithFormat:@"code = %ld\nmessage=%@",(long)authResponse.detailCode,authResponse.errorMessage];
            self.controller.authInfoTextView.text = string;
        }
    }
    
}

@end

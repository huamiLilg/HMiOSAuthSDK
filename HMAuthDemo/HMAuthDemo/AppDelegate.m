//
//  AppDelegate.m
//  HMAuthPartnerDemo
//
//  Created by 李林刚 on 2017/4/24.
//  Copyright © 2017年 huami. All rights reserved.
//

#import "AppDelegate.h"
#import "HMAuthViewController.h"

#import <libHuamiSDK/HMApi.h>

@interface AppDelegate ()<HMApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
     注意：
     - HMApiAuthPolicyHealthOnly:   只用华米健康
     - HMApiAuthPolicyMiFitOnly:    只用小米运动
     - HMApiAuthPolicyWatchOnly:    只用手表助手
     
     授权策略只能使用以上三个，在华米各个应用数据没打通之前，后面三个选项使用也是多余的，反而会引起不必要的疑问，切记！！！
     */
    [HMApi registerAppWithAuthPolicy:HMApiAuthPolicyMiFitOnly];
    
    HMAuthViewController *viewController = [[HMAuthViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    return [HMApi handleOpenURL:url delegate:self];
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
        }
    }

}

@end

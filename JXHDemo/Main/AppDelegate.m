//
//  AppDelegate.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/16/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTableViewController.h"
#import "MainTabBarController.h"
#import "NewFeatureViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 初始化window
    self.window = [[UIWindow alloc] init];
    // window跟屏幕一样大
    self.window.frame = [UIScreen mainScreen].bounds;
    // window背景色
    self.window.backgroundColor = [UIColor whiteColor];
    // 设置底部导航根控制器
    [self setupRootViewController];
    
    return YES;
}

/**
 *  根据是不是第一次登录，设置根控制器，如果是第一次登录则进入欢迎界面，否则直接进入主页面
 */
- (void)setupRootViewController
{
    // 版本号key
    NSString *key = (NSString *)kCFBundleVersionKey;
    // 当前最新应用的版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    // 沙盒中存储的登录过的应用版本号
    NSString *savedVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 判断是否第一次进入当前版本
    if ([version isEqualToString:savedVersion])
    {
        // 不是第一次(进入主界面)
        self.window.rootViewController = [[MainTabBarController alloc] init];
    }
    else
    {
        // 保存版本号
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // 第一次登录(显示新特性欢迎界面)
        self.window.rootViewController = [[NewFeatureViewController alloc] init];
    }
}

/**
 *  注册远程通知服务
 */
- (void)setupRegisterForRemoteNotification
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) // iOS8和以后
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                                                              categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert |UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    }
}

/**
 *  获取DeviceToken
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *device = [deviceToken description];
    device = [device stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    device = [device stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 存储token
    [[NSUserDefaults standardUserDefaults] setObject: device forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/**
 *  接收到远程通知时会调用
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}

@end
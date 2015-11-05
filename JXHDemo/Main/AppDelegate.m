//
//  AppDelegate.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/16/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTableViewController.h"
#import "ESTabBarController.h"
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
    
//    // 表格菜单
//    MainTableViewController *mainVC = [[MainTableViewController alloc] init];
//    // 根导航
//    UINavigationController *rootNavVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
//    // 跟导航作为window的跟控制器
//    self.window.rootViewController = rootNavVC;
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
        self.window.rootViewController = [[ESTabBarController alloc] init];
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

@end
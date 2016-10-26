//
//  MainTabBarController.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 16/7/21.
//  Copyright © 2016年 Jiangxh. All rights reserved.
//

#import "MainTabBarController.h"
#import "TabNavController.h"
#import "MainTableViewController.h"
#import "FoundationViewController.h"
#import "MyDemoViewController.h"
#import "FloatingViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.UIKit
    MainTableViewController *uikitVC = [[MainTableViewController alloc]init];
    [self addTabBarChildVC:uikitVC title:@"UIKit" icon:@"tabbar_home"];
    
    // 2.Foundation
    FoundationViewController *foundationVC = [[FoundationViewController alloc]init];
    [self addTabBarChildVC:foundationVC title:@"Foundation" icon:@"tabbar_home"];
    
    // 3.Demo
    MyDemoViewController *demoVC = [[MyDemoViewController alloc]init];
    [self addTabBarChildVC:demoVC title:@"Demo" icon:@"tabbar_home"];
    
    // 底部导航栏选中后的文字颜色
    self.tabBar.tintColor = RGBColor(28, 190, 164);
    
    // 添加悬浮窗
    FloatingViewController *floatVC = [[FloatingViewController alloc]init];
    [self addChildViewController:floatVC];
    [self.view addSubview:floatVC.view];
}

/**
 *  添加tabbar子控制器
 */
- (void) addTabBarChildVC:(UIViewController*)childVC title:(NSString *)title icon:(NSString *)icon {
    // 导航跟控制器
    TabNavController *navController = [[TabNavController alloc]initWithRootViewController:childVC];
    // 底部导航标题
    navController.tabBarItem.title = title;
    // 底部导航图标
    navController.tabBarItem.image = [UIImage imageNamed:icon];
    // 将当前子控制器添加到底部导航控制器
    [self addChildViewController:navController];
}

@end

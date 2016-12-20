//
//  RootViewController.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 20/12/16.
//  Copyright © 2016年 Jiangxh. All rights reserved.
//

#import "RootViewController.h"
#import "FloatingViewController.h"
#import "MainTabBarController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加悬浮窗
    FloatingViewController *floatVC = [[FloatingViewController alloc]init];
    [self addChildViewController:floatVC];
    [self.view addSubview:floatVC.view];
    
    // 底部导航
    MainTabBarController *mainTabBar = [[MainTabBarController alloc]init];
    [self addChildViewController:mainTabBar];
    [self.view addSubview:mainTabBar.view];
    
}

@end

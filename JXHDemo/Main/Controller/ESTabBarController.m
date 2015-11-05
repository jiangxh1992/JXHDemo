//
//  ESTabBarController.m
//  hospital
//
//  Created by eeesysmini2 on 15/10/14.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  tabbar控制器

#import "ESTabBarController.h"
#import "ESNavigationController.h"
#import "ESTabBar.h"
#import "ESTabBarButton.h"
#import "MainTableViewController.h"
#import "MyDemoViewController.h"
#import "FoundationViewController.h"

@interface ESTabBarController () <ESTabBarDelegate>

/**
 *  自定义tabbar
 */
@property (nonatomic, weak) ESTabBar *customTabBar;

@end

@implementation ESTabBarController
#pragma mark - lifecycle
/**
 *  view加载完成
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1. 初始化tabbar
    [self setupTabbar];
    
    // 2. 初始化所有的子控制器
    [self setupAllChildViewControllers];
    
    // 3. 退出登录通知监听
    [self setupNotification];
}

/**
 *  view将要出现
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 移除系统UITabBarButton
    [self removeTabBarButton];
}

/**
 *  view's layoutSubviews method is invoked
 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // 移除系统UITabBarButton
    [self removeTabBarButton];
}

#pragma mark - private
/**
 *  移除系统UITabBarButton
 */
- (void)removeTabBarButton
{
    if (self.tabBar.subviews.count < self.customTabBar.subviews.count) return;
    
    for (UIView *child in self.tabBar.subviews)
    {
        if ([child isKindOfClass:[UIControl class]])
        {
            [child removeFromSuperview];
        }
    }
}

/**
 *  退出登录通知监听
 */
- (void)setupNotification
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(logout) name:@"Logout" object:nil];
}

/**
 *  退出
 */
- (void)logout
{
    // 1.设置按钮的状态
    self.customTabBar.selectedButton.selected = NO;
    ESTabBarButton *button = (ESTabBarButton *)[self.customTabBar viewWithTag:ESTabBarTagStart + 0];
    button.selected = YES;
    self.customTabBar.selectedButton = button;
    
    // 2.切换页面
    self.selectedIndex = 0;
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    // 自定义tabbar
    ESTabBar *customTabBar = [[ESTabBar alloc] init];
    self.customTabBar = customTabBar;
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1. UIKit测试
    MainTableViewController *uikit = [[MainTableViewController alloc] init];
    [self setupChildViewController:uikit title:@"UIKit" imageName:@"tabbar_home"];
    // 2. Foundation基本用法
    FoundationViewController *foundation = [[FoundationViewController alloc] init];
    [self setupChildViewController:foundation title:@"Foundation" imageName:@"tabbar_home"];
    // 3. 我的自定义功能
    MyDemoViewController *demo = [[MyDemoViewController alloc] init];
    [self setupChildViewController:demo title:@"Demo" imageName:@"tabbar_home"];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName
{
    NSString *selectedImageName = [imageName stringByAppendingString:@"_selected"];
    [self setupChildViewController:childVc title:title imageName:imageName selectedImageName:selectedImageName];
}


/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.1 设置控制器的属性
    childVc.title = title;
    // 1.2 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    // 1.3 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    
    // 如果是iOS7不渲染选中图片
    if (iOS7)
    {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    else
    {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    // 2. 包装一个导航控制器
    UINavigationController *nav = [[ESNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3. 添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

# pragma mark - ESTabBarDelegate
/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(ESTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to checkLogin:(BOOL)check
{
    // 跳转到登录界面
    if (check)
    {
//        LoginViewController *vc = [[LoginViewController alloc] init];
//        vc.delegate = self;
//        ESNavigationController *nav = [[ESNavigationController alloc] initWithRootViewController:vc];
//        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
//    if ((to - ESTabBarTagStart) == 1) // 切换到问答控制器
//    {
//        [self.quest refreshFromOther:(from - ESTabBarTagStart) != 1];
//    }
    
    // 把tabbar控制器切换到当前选中按钮对应的页面
    self.selectedIndex = to - ESTabBarTagStart;
}

#pragma mark - LoginViewDelegate
/**
 *  登录成功后的回调
 */
//- (void)loginViewControllerLoginSuccess:(LoginViewController *)vc
//{
//    // 1.设置按钮的状态
//    self.customTabBar.selectedButton.selected = NO;
//    ESTabBarButton *button = (ESTabBarButton *)[self.customTabBar viewWithTag:ESTabBarTagStart + 3];
//    button.selected = YES;
//    self.customTabBar.selectedButton = button;
//    
//    // 2.切换页面
//    self.selectedIndex = 3;
//}

@end
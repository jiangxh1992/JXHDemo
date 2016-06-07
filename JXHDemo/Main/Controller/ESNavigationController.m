//
//  ESNavigationController.m
//  sdfyy
//
//  Created by eeesysmini2 on 15/10/15.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  导航控制器

#import "ESNavigationController.h"

@implementation ESNavigationController

#pragma mark - lifecycle
/**
 *  第一次使用这个类的时候会调用(1个类只会调用1次)
 */
+ (void)initialize
{
    // 1. 设置导航栏主题
    [self setupNavBarTheme];

    // 2. 设置导航栏按钮主题
    [self setupBarButtonItemTheme];
}

#pragma mark - private
/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme
{
    // 1. 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 2. 设置背景
    if (!IOS7)
    {
        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    // 3. 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19];
    [navBar setTitleTextAttributes:textAttrs];
    
    // 4. 导航栏系统自带图标颜色
    navBar.tintColor = RGBColor(55, 55, 55);
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme
{
    // 1. 获取整个项目中的导航栏按钮
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 2. 设置背景
    if (!IOS7)
    {
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    
    // 3. 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = IOS7 ? [UIColor blackColor] : [UIColor grayColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:IOS7 ? 16 : 12];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    // Disabled下的文字属性
    NSMutableDictionary *textAttrsDisabled = [NSMutableDictionary dictionary];
    textAttrsDisabled[NSForegroundColorAttributeName] = IOS7 ? [UIColor grayColor] : [UIColor grayColor];
    textAttrsDisabled[NSFontAttributeName] = [UIFont systemFontOfSize:IOS7 ? 16 : 12];
    [item setTitleTextAttributes:textAttrsDisabled forState:UIControlStateDisabled];
}

/**
 *  添加自定义返回按钮
 */
- (void)addBackBarButtonItem:(UIViewController *)viewController
{
    // 1. 导航栏设置返回按钮
//    viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back" target:self action:@selector(back)];
    
    // 2. 自定义返回按钮和ios7手势返回冲突
    if (IOS7)
    {
        self.interactivePopGestureRecognizer.enabled = YES;
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

/**
 *  导航栏返回按钮点击
 */
- (void)back
{
    // 1. pop回上一个控制器
    [self popViewControllerAnimated:YES];
}

# pragma mark - super
/**
 *  拦截控制器push
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 1. 如果不是nav的根控制器
    if (self.viewControllers.count > 0)
    {
        // 1.1 push时隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 1.2 添加自定义返回按钮
        [self addBackBarButtonItem:viewController];
    }
    
    // 2 设置控制器背景颜色
    viewController.view.backgroundColor = RGBColor(230, 230, 230);

    // 3. edgesForExtendedLayout属性
    if (IOS7)
    {
        if ([viewController isMemberOfClass:[UITableViewController class]])
        {
            // 导航栏有穿透效果
            viewController.edgesForExtendedLayout = UIRectEdgeTop;
        }
        else
        {
            // 导航栏没有穿透效果
            viewController.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    
    // 3. push
    [super pushViewController:viewController animated:animated];
}

@end
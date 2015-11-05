//
//  ESTabBar.m
//  smh
//
//  Created by yh on 14/11/17.
//  Copyright (c) 2014年 eeesys. All rights reserved.
//

// 按钮初始tag
NSInteger ESTabBarTagStart = 200;

#import "ESTabBar.h"
#import "ESTabBarButton.h"

@interface ESTabBar()

@end

@implementation ESTabBar

#pragma mark - init
/**
 *  根据frame初始化
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 1. 初始化
        [self setup];
    }
    return self;
}

#pragma mark - private
/**
 *  初始化
 */
- (void)setup
{
    if (!iOS7)
    {
         // 非iOS7下,设置tabbar的背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(ESTabBarButton *)button
{
    // 1. 默认检查状态
    BOOL check = NO;
    
    // 2. 点了哪一个按钮
    if (button.tag == (ESTabBarTagStart + 3)) // 点击了"我"按钮
    {
        // 1. 检查是否有缓存账号
//        Account *account = [AccountTool account];
//        if (!account) // 没有账号
//        {
//            // 需要登录
//            check = !check;
//        }
    }
    
    // 3.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:checkLogin:)])
    {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag checkLogin:check];
    }
    
    if (!check)
    {
        // 4.设置按钮的状态
        self.selectedButton.selected = NO;
        button.selected = YES;
        self.selectedButton = button;
    }
}

#pragma mark - public
/**
 *  添加自定义tabBarbutton
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1. 创建按钮
    ESTabBarButton *button = [[ESTabBarButton alloc] init];
    [self addSubview:button];
    
    // 2. 设置数据
    button.item = item;
    
    // 3. 监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 4. 默认选中第0个按钮
    if (self.subviews.count == 1)
    {
        [self buttonClick:button];
    }
}

#pragma mark - super
/**
 *  调整子视图
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1. 按钮的frame数据
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index < self.subviews.count; index++)
    {
        // 2.取出按钮
        ESTabBarButton *button = self.subviews[index];
        
        // 3.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 4.绑定tag
        button.tag = ESTabBarTagStart + index;
    }
}

@end
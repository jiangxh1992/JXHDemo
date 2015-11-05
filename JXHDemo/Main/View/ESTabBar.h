//
//  ESTabBar.h
//  smh
//
//  Created by yh on 14/11/17.
//  Copyright (c) 2014年 eeesys. All rights reserved.
//  自定义tabbar

//  按钮初始tag
extern NSInteger ESTabBarTagStart;

#import <UIKit/UIKit.h>
@class ESTabBar;
@class ESTabBarButton;

@protocol ESTabBarDelegate <NSObject>

@optional
/**
 *  从一个按钮切换到另一个
 */
- (void)tabBar:(ESTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to checkLogin:(BOOL)check;

@end

@interface ESTabBar : UIView

/**
 *  当前选中的按钮
 */
@property (nonatomic, weak) ESTabBarButton *selectedButton;

/**
 *  代理
 */
@property (nonatomic, weak) id <ESTabBarDelegate> delegate;

/**
 *  用对应控制器的UITabBarItem来添加自定义tabBarbutton
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
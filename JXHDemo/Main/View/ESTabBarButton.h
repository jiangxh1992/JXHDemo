//
//  ESTabBarButton.h
//  smh
//
//  Created by yh on 14/11/17.
//  Copyright (c) 2014年 eeesys. All rights reserved.
//  自定义tabbar中的按钮

#import <UIKit/UIKit.h>

@interface ESTabBarButton : UIButton

/**
 *  接收对应控制器传来的UITabBarItem模型
 */
@property (nonatomic, strong) UITabBarItem *item;

@end
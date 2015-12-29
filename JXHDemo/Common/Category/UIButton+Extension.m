//
//  UIButton+Extension.m
//  smh
//
//  Created by yh on 15/3/1.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

/**
 *  快速创建一个button
 */
+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [self buttonWithTitle:title normalBg:nil highlightedBg:nil target:target action:action];
}

/**
 *  快速创建一个button
 */
+ (instancetype)buttonWithTitle:(NSString *)title bg:(NSString *)bg target:(id)target action:(SEL)action
{
    NSString *highlightedBg = [bg stringByAppendingString:@"_highlighted"];
    return [self buttonWithTitle:title normalBg:bg highlightedBg:highlightedBg target:target action:action];
}

/**
 *  快速创建一个button
 */
+ (instancetype)buttonWithTitle:(NSString *)title normalBg:(NSString *)normalBg highlightedBg:(NSString *)highlightedBg target:(id)target action:(SEL)action
{
    // 1. 创建button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 2. 设置文字
    [button setTitle:title forState:UIControlStateNormal];
    // 3. 文字颜色
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 4. 正常状态下的背景图片
    [button setBackgroundImage:[UIImage resizedImageWithName:normalBg] forState:UIControlStateNormal];
    // 5. 高亮状态下的背景图片
    [button setBackgroundImage:[UIImage resizedImageWithName:highlightedBg] forState:UIControlStateHighlighted];
    // 6. 监听方法
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end
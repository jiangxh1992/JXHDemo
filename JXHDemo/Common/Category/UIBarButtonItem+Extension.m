//
//  UIBarButtonItem+Extension.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

/**
 *  快速创建一个显示图片的UIBarButtonItem
 *  @param icon   普通图片名称
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action
{
    NSString *highlighted = [icon stringByAppendingString:@"_highlighted"];
    return [self itemWithIcon:icon highIcon:highlighted target:target action:action];
}

/**
 *  快速创建一个显示图片的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    // 创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 正常状态下背景图片
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    // 高亮状态下背景图片
    [button setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    // 设置frame
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    // 点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
//
//  ESItem.m
//  sdfyy
//
//  Created by yh on 15/2/4.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESItem.h"

@implementation ESItem

/**
 *  标题文字占屏幕宽度比例
 */
- (CGFloat)titleScale
{
    if (!_titleScale)
    {
        _titleScale = 0.4;
    }
    return _titleScale;
}

/**
 *  标题font
 */
- (UIFont *)titleFont
{
    if (!_titleFont)
    {
        _titleFont = [UIFont systemFontOfSize:16];
    }
    return _titleFont;
}

/**
 *  子标题font
 */
- (UIFont *)subtitleFont
{
    if (!_subtitleFont)
    {
        _subtitleFont = [UIFont systemFontOfSize:16];
    }
    return _subtitleFont;
}

/**
 *  标题颜色
 */
- (UIColor *)titleColor
{
    if (!_titleColor)
    {
        _titleColor = [UIColor grayColor];
    }
    return _titleColor;
}

/**
 *  快速创建一个ESItem或子类
 */
+ (instancetype)item
{
    return [[self alloc] init];
}

/**
 *  快速创建一个ESItem或子类
 */
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle
{
    ESItem *item = [self item];
    item.title = title;
    item.subtitle = subtitle;
    return item;
}

@end
//
//  UILabel+Extension.m
//  smh
//
//  Created by yh on 15/2/2.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

/**
 *  创建Label
 */
+ (instancetype)label
{
    return [self labelWithFont:nil];
}

/**
 *  根据字体创建Label
 */
+ (instancetype)labelWithFont:(UIFont *)font
{
    // 创建
    UILabel *label = [[UILabel alloc] init];
    // 多少行
    label.numberOfLines = 0;
    // 文字颜色
    label.textColor = [UIColor blackColor];
    // 背景颜色
    label.backgroundColor = [UIColor clearColor];
    // 设置字体
    if (font)
    {
        label.font = font;
    }
    return label;
}

@end
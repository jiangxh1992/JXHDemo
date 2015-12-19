//
//  UILabel+Extension.m
//  sdfyy
//
//  Created by yh on 15/2/2.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "UILabel+YH.h"

@implementation UILabel (YH)

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
    // 设置字体
    if (font)
    {
        label.font = font;
    }
    return label;
}

@end
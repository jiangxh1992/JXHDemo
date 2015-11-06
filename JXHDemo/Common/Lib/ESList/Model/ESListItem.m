//
//  ESListItem.m
//  sdfyy
//
//  Created by yh on 15/1/31.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESListItem.h"

@implementation ESListItem

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
        _subtitleFont = [UIFont systemFontOfSize:14];
    }
    return _subtitleFont;
}


@end
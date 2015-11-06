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

@end
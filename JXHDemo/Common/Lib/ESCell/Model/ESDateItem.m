//
//  ESDateItem.m
//  sdfyy
//
//  Created by yh on 15/2/4.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESDateItem.h"

@implementation ESDateItem

/**
 *  最小日期
 */
- (NSDate *)minimumDate
{
    if (!_minimumDate)
    {
        _minimumDate = [NSDate dateWithString:@"1900-01-01" format:self.format];
    }
    return _minimumDate;
}

/**
 *  最大日期
 */
- (NSDate *)maximumDate
{
    if (!_maximumDate)
    {
        _maximumDate = [NSDate date];
    }
    return _maximumDate;
}

/**
 *  日期格式
 */
- (NSString *)format
{
    if (!_format)
    {
        _format = @"yyyy-MM-dd";
    }
    return _format;
}

@end
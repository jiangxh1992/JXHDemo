//
//  NSDate+YH.m
//  sdfyy
//
//  Created by yh on 15/3/1.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "NSDate+YH.h"

@implementation NSDate (YH)

/**
 *  字符串时间转NSDate
 */
+ (NSDate *)yhdateWithString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:string];
}

/**
 *  NSDate转字符串时间
 */
+ (NSString *)yhstringWithDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

@end
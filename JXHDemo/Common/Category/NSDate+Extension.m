//
//  NSDate+Extension.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  字符串时间转NSDate
 */
+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:string];
}

/**
 *  NSDate转字符串时间
 */
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

/**
 *  根据日期计算星期几
 */
- (NSString *)week
{
    // 日期字典
    NSDictionary *weekDict = @{@"7": @"星期日",
                               @"1": @"星期一",
                               @"2": @"星期二",
                               @"3": @"星期三",
                               @"4": @"星期四",
                               @"5": @"星期五",
                               @"6": @"星期六"
                               };
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setLocale:[NSLocale systemLocale]];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return weekDict[[NSString stringWithFormat:@"%ld",(long)comps.weekday]];
}

/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    NSDate *selfDate = [self dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

@end
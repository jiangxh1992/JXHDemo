//
//  NSDate+Extension.h
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 *  字符串时间转NSDate
 */
+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format;

/**
 *  NSDate转字符串时间
 */
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;

/**
 *  根据日期计算星期几
 */
- (NSString *)week;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

@end
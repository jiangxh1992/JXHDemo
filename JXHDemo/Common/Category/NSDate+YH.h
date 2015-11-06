//
//  NSDate+YH.h
//  sdfyy
//
//  Created by yh on 15/3/1.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YH)

/**
 *  字符串时间转NSDate
 */
+ (NSDate *)yhdateWithString:(NSString *)string format:(NSString *)format;

/**
 *  NSDate转字符串时间
 */
+ (NSString *)yhstringWithDate:(NSDate *)date format:(NSString *)format;

@end
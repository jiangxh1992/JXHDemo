//
//  NSString+Extension.h
//  smh
//
//  Created by yh on 15/1/5.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
 *  根据文字字体和最大尺寸计算文字宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

/**
 *  拼接文件名
 */
- (NSString *)fileNameAppend:(NSString *)appendString;

/**
 *  plist文件在mainBundle中的路径
 */
+ (NSString *)pathForResource:(NSString *)resource;

/**
 *  去空格
 */
- (NSString *)trim;

/**
 *  本地化文字
 */
- (NSString *)localizedString;

/**
 *  多少分钟前
 */
- (NSString *)minutesAgo;

/**
 *  手机号码验证
 */
- (BOOL)validateMobile;

/**
 *  身份证号验证
 */
- (BOOL)validateIdentityCard;

/**
 *  是否纯数字
 */
- (BOOL)validateNumber;

/**
 *  NSDictionary转json字符串
 */
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;

/**
 *  NSArray转json字符串
 */
+ (NSString *)jsonStringWithArray:(NSArray *)array;

/**
 *  NSString转json字符串
 */
+ (NSString *)jsonStringWithString:(NSString *)string;

/**
 *  NSObject转json字符串
 */
+ (NSString *)jsonStringWithObject:(id)object;

/**
 *  根据区号返回城市名称
 */
- (NSString *)cityName;

- (CGSize)sizeWithFont:(UIFont *)font;
@end
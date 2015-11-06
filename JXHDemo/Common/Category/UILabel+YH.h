//
//  UILabel+Extension.h
//  sdfyy
//
//  Created by yh on 15/2/2.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YH)

/**
 *  创建Label
 */
+ (instancetype)yhlabel;

/**
 *  根据字体创建Label
 */
+ (instancetype)yhlabelWithFont:(UIFont *)font;

@end
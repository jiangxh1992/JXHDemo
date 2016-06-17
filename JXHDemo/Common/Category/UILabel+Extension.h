//
//  UILabel+Extension.h
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

/**
 *  创建Label
 */
+ (instancetype)label;

/**
 *  根据字体创建Label
 */
+ (instancetype)labelWithFont:(UIFont *)font;

@end
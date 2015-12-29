//
//  UIButton+Extension.h
//  smh
//
//  Created by yh on 15/3/1.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 *  快速创建一个button
 */
+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 *  快速创建一个button
 */
+ (instancetype)buttonWithTitle:(NSString *)title bg:(NSString *)bg target:(id)target action:(SEL)action;

/**
 *  快速创建一个button
 */
+ (instancetype)buttonWithTitle:(NSString *)title normalBg:(NSString *)normalBg highlightedBg:(NSString *)highlightedBg target:(id)target action:(SEL)action;

@end
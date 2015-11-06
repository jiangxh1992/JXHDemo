//
//  UIButton+Extension.h
//  sdfyy
//
//  Created by yh on 15/3/1.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YH)

/**
 *  快速创建一个button
 */
+ (instancetype)yhbuttonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
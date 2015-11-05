//
//  UIAlertView+DIY.h
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/28/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//
/**
 *  扩展UIAlertView的类方法
 *  扩展后定义的UIAlertView组件可以自由添加一个自定义格式的UILabel或UIView
 */
#import <UIKit/UIKit.h>

@interface UIAlertView (DIY)

/**
 *  添加子视图
 */
- (void) addUIView: (UIView *)view;
/**
 *  添加居左对齐的UILabel
 */
- (void) addLeftAlignmentLabel:(UILabel *)label;
/**
 *  添加一个完全自定义的UILabel
 */
- (void) addLabel:(UILabel *)label;

@end
//
//  ESFieldItem.h
//  sdfyy
//
//  Created by yh on 15/2/4.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  右边显示输入框

#import "ESItem.h"

@interface ESFieldItem : ESItem

/**
 *  提示文字
 */
@property (nonatomic, copy) NSString *placeholder;

/**
 *  是否密码框
 */
@property (nonatomic, assign) BOOL secure;

/**
 *  键盘类型
 */
@property(nonatomic, assign) UIKeyboardType keyboardType;

/**
 *  输入框开始编辑的回调
 */
@property (nonatomic, copy) void (^operationStart)(NSString *subtitle);

/**
 *  输入框文字变化的回调
 */
@property (nonatomic, copy) void (^operationValueChange)(NSString *subtitle);

@end
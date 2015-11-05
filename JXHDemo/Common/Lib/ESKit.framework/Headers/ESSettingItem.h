//
//  ESSettingItem.h
//  sdfyy
//
//  Created by yh on 15/1/17.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  一个ESSettingItem模型来描述每一行的信息:图标、标题、子标题、右边的样式（箭头、数字、开关等）

#import <Foundation/Foundation.h>

@interface ESSettingItem : NSObject

/**
 *  图标
 */
@property (nonatomic, copy) NSString *icon;

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  子标题
 */
@property (nonatomic, copy) NSString *subtitle;

/**
 *  右边显示的数字标记
 */
@property (nonatomic, copy) NSString *badgeValue;

/**
 *  点击cell，需要跳转到哪个控制器
 */
@property (nonatomic, assign) Class destClass;

/**
 *  点击这行cell后的操作
 */
@property (nonatomic, copy) void (^operation)();

/**
 *  根据标题和图标创建ESSettingItem
 *
 *  @param title 标题
 *  @param icon  图标
 */
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;

/**
 *  根据标题创建ESSettingItem
 *
 *  @param title 标题
 */
+ (instancetype)itemWithTitle:(NSString *)title;

@end
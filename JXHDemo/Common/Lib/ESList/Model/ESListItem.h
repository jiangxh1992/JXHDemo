//
//  ESListItem.h
//  sdfyy
//
//  Created by yh on 15/1/31.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  对应每一行cell数据

#import <Foundation/Foundation.h>

@interface ESListItem : NSObject

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  标题font
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 *  子标题
 */
@property (nonatomic, copy) NSString *subtitle;

/**
 *  子标题font
 */
@property (nonatomic, strong) UIFont *subtitleFont;

/**
 *  原始数据模型
 */
@property (nonatomic, strong) id original;

@end
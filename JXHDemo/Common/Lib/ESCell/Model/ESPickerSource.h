//
//  ESPickerSource.h
//  sdfyy
//
//  Created by yh on 15/3/2.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  下拉框数据源

#import <Foundation/Foundation.h>

@interface ESPickerSource : NSObject

/**
 *  主键代号等
 */
@property (nonatomic, copy) NSString *code;

/**
 *  名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  值
 */
@property (nonatomic, copy) NSString *value;

/**
 *  下一级数据
 */
@property (nonatomic, strong) NSArray *subs;

@end
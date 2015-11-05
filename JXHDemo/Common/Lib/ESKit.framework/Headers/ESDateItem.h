//
//  ESDateItem.h
//  sdfyy
//
//  Created by yh on 15/2/4.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  右边显示日期控件

#import "ESItem.h"

@interface ESDateItem : ESItem

/**
 *  最小日期
 */
@property (nonatomic, strong) NSDate *minimumDate;

/**
 *  最大日期
 */
@property (nonatomic, strong) NSDate *maximumDate;

/**
 *  日期格式
 */
@property (nonatomic, copy) NSString *format;

@end
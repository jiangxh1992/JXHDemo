//
//  ESPickerItem.h
//  sdfyy
//
//  Created by yh on 15/2/4.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  右边显示UIPickerView

#import "ESItem.h"
#import "ESPickerSource.h"

@interface ESPickerItem : ESItem

/**
 *  数据源
 */
@property (nonatomic, strong) NSArray *source;

@end
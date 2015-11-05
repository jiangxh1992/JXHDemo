//
//  ESGroup.h
//  sdfyy
//
//  Created by yh on 15/2/4.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  UITableView表格分组

#import <Foundation/Foundation.h>

@interface ESGroup : NSObject

/**
 *  组头
 */
@property (nonatomic, copy) NSString *header;

/**
 *  组尾
 */
@property (nonatomic, copy) NSString *footer;

/**
 *  这组的所有模型（数组中存放的是ESCellFrame模型）
 */
@property (nonatomic, strong) NSArray *items;

/**
 *  快速创建一个ESGroup对象
 */
+ (instancetype)group;

@end
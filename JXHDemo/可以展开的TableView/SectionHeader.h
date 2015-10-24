//
//  SectionHeader.h
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/23/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//  表格section header的内容数据模型

#import <Foundation/Foundation.h>

@interface SectionHeader : NSObject

/**
 *  指示按钮图标
 */
@property (nonatomic, copy)NSString *icon;

/**
 *  section标题
 */
@property (nonatomic, copy)NSString *title;

@end

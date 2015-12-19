//
//  NodeRecord.h
//  slyy_department_edition
//
//  Created by jiangxh on 10/27/15.
//  Copyright (c) 2015 eeesysmini2. All rights reserved.
//  时间结点就诊记录模型

#import <Foundation/Foundation.h>

@interface NodeRecord : NSObject

/**
 *  就诊时间
 */
@property (nonatomic, copy)NSString *date;

/**
 *  就诊类型
 */
@property (nonatomic, copy)NSString *type;

/**
 *  就诊内容详情
 */
@property (nonatomic, copy)NSString *detail;

/**
 *  结点高度
 */
@property (nonatomic)CGFloat cellHeight;

/**
 *  结点行号
 */
@property (nonatomic)NSInteger row;

/**
 *  结点颜色
 */
@property (nonatomic, strong)UIColor *nodeColor;

/**
 *  箭头资源
 */
@property (nonatomic, copy)NSString *arrowName;

/**
 *  构造函数
 */
-(id)initWithDic:(NSDictionary *)dic;
+(id)initWithDic:(NSDictionary *)dic;

@end

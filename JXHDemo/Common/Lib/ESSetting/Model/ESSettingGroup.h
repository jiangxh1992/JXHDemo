//
//  ESSettingGroup.h
//  sdfyy
//
//  Created by yh on 15/1/17.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  一个ESSettingGroup模型来描述每组的信息：组头、组尾、这组的所有行

#import <Foundation/Foundation.h>

@interface ESSettingGroup : NSObject

/**
 *  组头
 */
@property (nonatomic, copy) NSString *header;

/**
 *  组尾
 */
@property (nonatomic, copy) NSString *footer;

/**
 *  这组的所有模型（数组中存放的是ESSettingItem模型）
 */
@property (nonatomic, strong) NSArray *items;

/**
 *  快速创建一个ESSettingGroup对象
 */
+ (instancetype)group;

@end
//
//  ESSettingItem.m
//  sdfyy
//
//  Created by yh on 15/1/17.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESSettingItem.h"

@implementation ESSettingItem

/**
 *  根据标题和图标创建ESSettingItem
 *
 *  @param title 标题
 *  @param icon  图标
 */
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    ESSettingItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

/**
 *  根据标题创建ESSettingItem
 *
 *  @param title 标题
 */
+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}

@end
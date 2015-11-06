//
//  ESBaseSettingViewController.h
//  sdfyy
//
//  Created by yh on 15/1/17.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  设置界面父类，其他类似界面只需要给出数据

#import <UIKit/UIKit.h>
#import "ESSettingGroup.h"
#import "ESSettingItem.h"
#import "ESSettingArrowItem.h"
#import "ESSettingSwitchItem.h"
#import "ESSettingLabelItem.h"
#import "ESSettingCheckItem.h"

typedef enum {
    ESBaseSettingSectionMarginSmall,
    ESBaseSettingSectionMarginBig
} ESBaseSettingSectionMargin;

@interface ESBaseSettingViewController : UITableViewController

/**
 *  所有组数据模型
 */
@property (nonatomic, strong) NSMutableArray *groups;

/**
 *  sction之间的距离
 */
@property (nonatomic, assign) ESBaseSettingSectionMargin sctionMargin;

@end
//
//  ESSettingCell.h
//  sdfyy
//
//  Created by yh on 15/1/17.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  设置模块中的自定义cell

// cell高度
extern CGFloat const ESBaseSettingViewCellH;

#import <UIKit/UIKit.h>
@class ESSettingItem;

@interface ESSettingCell : UITableViewCell

/**
 *  cell对应的item数据
 */
@property (nonatomic, strong) ESSettingItem *item;

@end
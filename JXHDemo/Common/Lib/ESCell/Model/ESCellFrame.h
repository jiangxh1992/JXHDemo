//
//  ESCellFrame.h
//  sdfyy
//
//  Created by yh on 15/2/10.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ESItem;

@interface ESCellFrame : NSObject

/**
 *  模型数据
 */
@property (nonatomic, strong) ESItem *item;

/**
 *  cell高度
 */
@property (nonatomic, readonly) CGFloat cellHeight;

/**
 *  标题frame
 */
@property (nonatomic, readonly) CGRect titleFrame;

/**
 *  子标题frame
 */
@property (nonatomic, readonly) CGRect subtitleFrame;

/**
 *  快速创建ESCellFrame
 */
+ (instancetype)cellFrameWithItem:(ESItem *)item;

@end
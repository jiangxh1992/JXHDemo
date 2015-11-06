//
//  ESListCellFrame.h
//  sdfyy
//
//  Created by yh on 15/1/31.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ESListItem;

@interface ESListCellFrame : NSObject

/**
 *  cell数据模型
 */
@property (nonatomic, strong) ESListItem *item;

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
 *  创建ESListCellFrame
 */
+ (instancetype)cellFrameWithItem:(ESListItem *)item;

@end
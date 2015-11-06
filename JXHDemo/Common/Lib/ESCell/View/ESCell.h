//
//  ESCell.h
//  sdfyy
//
//  Created by yh on 15/2/10.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ESCellFrame;
@class ESCell;

@protocol ESCellDelegate <NSObject>

@optional
/**
 *  cell将要刷新
 */
- (void)cellWillReload:(ESCell *)cell;

@end

@interface ESCell : UITableViewCell

/**
 *  控件frame
 */
@property (nonatomic, strong) ESCellFrame *cellFrame;

/**
 *  代理
 */
@property (nonatomic, assign) id<ESCellDelegate> delegate;

/**
 *  cell中的输入框成为第一响应者
 */
- (void)becomeFirst;

@end
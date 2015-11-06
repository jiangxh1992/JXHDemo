//
//  ESListCell.h
//  sdfyy
//
//  Created by yh on 15/1/31.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  自定义cell视图,有标题，子标题，右边指示箭头

#import <UIKit/UIKit.h>
@class ESListCellFrame;

@interface ESListCell : UITableViewCell

/**
 *  控件frame模型
 */
@property (nonatomic, strong) ESListCellFrame *cellFrame;

@end
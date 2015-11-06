//
//  ESListCellFrame.m
//  sdfyy
//
//  Created by yh on 15/1/31.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESListCellFrame.h"
#import "ESListItem.h"

@implementation ESListCellFrame

/**
 *  创建ESListCellFrame
 */
+ (instancetype)cellFrameWithItem:(ESListItem *)item
{
    ESListCellFrame *cellFrame = [[ESListCellFrame alloc] init];
    cellFrame.item = item;
    return cellFrame;
}

#pragma mark - setters
/**
 *  设置数据模型
 */
- (void)setItem:(ESListItem *)item
{
    _item = item;
    // 标题
    CGFloat titleX = CellMargin * 2;
    CGFloat titleY = CellMargin * 2;
    CGFloat titleW = ApplicationW - 6 * CellMargin;
    CGFloat titleH = [item.title sizeWithFont:item.titleFont maxW:titleW].height;
    _titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
    // cell高度
    _cellHeight = CGRectGetMaxY(_titleFrame) + CellMargin * 2;
}

@end
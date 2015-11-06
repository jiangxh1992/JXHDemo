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
    // 子标题
    CGFloat subtitleX = titleX;
    CGFloat subtitleY = CGRectGetMaxY(_titleFrame) + CellMargin / 2;
    CGFloat subtitleW = titleW;
    CGFloat subtitleH = [item.subtitle sizeWithFont:item.subtitleFont maxW:subtitleW].height;
    _subtitleFrame = CGRectMake(subtitleX, subtitleY, subtitleW, subtitleH);
    // cell高度
    if (item.subtitle)
        _cellHeight = CGRectGetMaxY(_subtitleFrame) + CellMargin * 2;
    else
        _cellHeight = CGRectGetMaxY(_titleFrame) + CellMargin * 2;
}

@end
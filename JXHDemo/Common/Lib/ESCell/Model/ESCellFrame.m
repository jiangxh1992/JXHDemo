//
//  ESCellFrame.m
//  sdfyy
//
//  Created by yh on 15/2/10.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESCellFrame.h"
#import "ESItem.h"
#import "ESLabelItem.h"
#import "ESFieldItem.h"
#import "ESPickerItem.h"
#import "ESDateItem.h"

@implementation ESCellFrame

#pragma mark - 创建
/**
 *  快速创建ESCellFrame
 */
+ (instancetype)cellFrameWithItem:(ESItem *)item
{
    ESCellFrame *cellFrame = [[self alloc] init];
    cellFrame.item = item;
    return cellFrame;
}

#pragma mark - 公共方法
/**
 *  设置ESItem
 */
- (void)setItem:(ESItem *)item
{
    _item = item;
    
    // 标题
    CGFloat titleX = CellMargin * 1.5;
    CGFloat titleY = CellMargin * 1.5;
    CGFloat titleW = ApplicationW * item.titleScale - 2 * titleX;
    CGFloat titleH = [item.title sizeWithFont:item.titleFont maxW:titleW].height;    _titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
    
    // 子标题
    if ([item isKindOfClass:[ESLabelItem class]]) // 普通文本
    {
        [self labelWithItem:item titleX:titleX];
    }
    else if ([item isKindOfClass:[ESFieldItem class]]) // 输入框
    {
        [self fieldWithItem:item titleX:titleX titleH:titleH];
    }
    else if ([item isKindOfClass:[ESDateItem class]]) // 日期选择
    {
        [self seleceWithItem:item titleX:titleX];
    }
    else if ([item isKindOfClass:[ESPickerItem class]]) // 选择框
    {
        [self seleceWithItem:item titleX:titleX];
    }
    
    // cell高度
    _cellHeight = CGRectGetMaxY(_titleFrame) > CGRectGetMaxY(_subtitleFrame) ? CGRectGetMaxY(_titleFrame) : CGRectGetMaxY(_subtitleFrame);
    _cellHeight += CellMargin * 1.5;
}

#pragma mark - 私有方法
/**
 *  计算普通文本frame
 */
- (void)labelWithItem:(ESItem *)item titleX:(CGFloat)titleX
{
    CGFloat subtitleX = CGRectGetMaxX(_titleFrame) + titleX;
    CGFloat subtitleY = CellMargin * 1.5;
    CGFloat subtitleW = ApplicationW * (1 - item.titleScale) - 2 * CellMargin * 1.5;
    CGFloat subtitleH = [item.subtitle sizeWithFont:item.subtitleFont maxW:subtitleW].height;
    _subtitleFrame = CGRectMake(subtitleX, subtitleY, subtitleW, subtitleH);
}

/**
 *  计算输入框frame
 */
- (void)fieldWithItem:(ESItem *)item titleX:(CGFloat)titleX titleH:(CGFloat)titleH
{
    CGFloat subtitleX = CGRectGetMaxX(_titleFrame) + titleX;
    CGFloat subtitleY = CellMargin * 1.5;
    CGFloat subtitleW = ApplicationW * (1 - item.titleScale) - CellMargin * 1.5;
    CGFloat subtitleH = titleH;
    _subtitleFrame = CGRectMake(subtitleX, subtitleY, subtitleW, subtitleH);
}

/**
 *  计算日期选择和下拉框
 */
- (void)seleceWithItem:(ESItem *)item titleX:(CGFloat)titleX
{
    CGFloat subtitleX = CGRectGetMaxX(_titleFrame) + titleX;
    CGFloat subtitleY = CellMargin * 1.5;
    CGFloat subtitleW = ApplicationW * (1 - item.titleScale) - 2 * CellMargin * 1.5;
    CGFloat subtitleH = [item.subtitle sizeWithFont:item.subtitleFont maxW:subtitleW].height;
    _subtitleFrame = CGRectMake(subtitleX, subtitleY, subtitleW, subtitleH);
}

@end
//
//  ESListCell.m
//  sdfyy
//
//  Created by yh on 15/1/31.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESListCell.h"
#import "ESListCellFrame.h"
#import "ESListItem.h"

@interface ESListCell ()

/**
 *  标题label
 */
@property (nonatomic, weak) UILabel *titleLabel;

/**
 *  子标题label
 */
@property (nonatomic, weak) UILabel *subtitleLabel;

/**
 *  箭头视图
 */
@property (nonatomic, strong) UIImageView *arrowView;

@end

@implementation ESListCell

#pragma mark - getters
/**
 *  获取标题label
 */
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        // 创建
        UILabel *titleLabel = [UILabel yhlabel];
        // 添加到cell中
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

#pragma mark - setters
/**
 *  设置控件frame模型
 */
- (void)setCellFrame:(ESListCellFrame *)cellFrame
{
    // 成员变量赋值
    _cellFrame = cellFrame;
    // 数据模型
    ESListItem *item = cellFrame.item;
    // 标题
    self.titleLabel.text = item.title;
    self.titleLabel.frame = cellFrame.titleFrame;
    self.titleLabel.font = item.titleFont;
    // 子标题
    self.subtitleLabel.text = item.subtitle;
    self.subtitleLabel.frame = cellFrame.subtitleFrame;
    self.subtitleLabel.font = item.subtitleFont;
}

/**
 *  获取子标题label
 */
- (UILabel *)subtitleLabel
{
    if (!_subtitleLabel)
    {
        // 创建
        UILabel *subtitleLabel = [UILabel yhlabel];
        // 添加到cell中
        [self.contentView addSubview:subtitleLabel];
        _subtitleLabel = subtitleLabel;
    }
    return _subtitleLabel;
}

/**
 *  获取arrowView
 */
- (UIImageView *)arrowView
{
    if (!_arrowView)
    {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
        _arrowView = arrowView;
    }
    return _arrowView;
}

#pragma mark - init
/**
 *  创建cell
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // 设置cell样式
        [self setup];
    }
    return self;
}

#pragma mark - private
/**
 *  设置cell样式
 */
- (void)setup
{
    // 设置accessoryView
    self.accessoryView = self.arrowView;
}

@end
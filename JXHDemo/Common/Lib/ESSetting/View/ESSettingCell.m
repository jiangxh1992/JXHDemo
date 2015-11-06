//
//  ESSettingCell.m
//  sdfyy
//
//  Created by yh on 15/1/17.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

// cell高度
CGFloat const ESBaseSettingViewCellH = 50;

#import "ESSettingCell.h"
#import "ESSettingItem.h"
#import "ESSettingArrowItem.h"
#import "ESSettingSwitchItem.h"
#import "ESSettingLabelItem.h"
#import "ESSettingCheckItem.h"
#import "ESBadgeView.h"

@interface ESSettingCell ()

/**
 *  箭头
 */
@property (nonatomic, strong) UIImageView *arrow;

/**
 *  开关
 */
@property (nonatomic, strong) UISwitch *rightSwitch;

/**
 *  文字
 */
@property (nonatomic, strong) UILabel *rightLabel;

/**
 *  打勾
 */
@property (nonatomic, strong) UIImageView *checkmark;

/**
 *  数字提醒
 */
@property (nonatomic, strong) ESBadgeView *badgeView;

@end

@implementation ESSettingCell

#pragma mark - getters
/**
 *  箭头
 */
- (UIImageView *)arrow
{
    if (!_arrow)
    {
        _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _arrow;
}

/**
 *  开关
 */
- (UISwitch *)rightSwitch
{
    if (!_rightSwitch)
    {
        _rightSwitch = [[UISwitch alloc] init];
        // 监听事件
        [_rightSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _rightSwitch;
}

/**
 *  文字
 */
- (UILabel *)rightLabel
{
    if (!_rightLabel)
    {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = [UIColor lightGrayColor];
        _rightLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_rightLabel];
    }
    return _rightLabel;
}

/**
 *  打勾
 */
- (UIImageView *)checkmark
{
    if (!_checkmark)
    {
        _checkmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
    }
    return _checkmark;
}

/**
 *  获取数字提醒
 */
- (ESBadgeView *)badgeView
{
    if (!_badgeView)
    {
        _badgeView = [[ESBadgeView alloc] init];
    }
    return _badgeView;
}

#pragma mark - setter方法
/**
 *  设置item模型
 */
- (void)setItem:(ESSettingItem *)item
{
    _item = item;
    
    // 1. 设置基本数据
    self.imageView.image = [UIImage imageWithName:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    // 2. 设置右边的内容
    if (item.badgeValue) // 有提醒数字（优先显示数字）
    {
        // 设置数字
        self.badgeView.badgeValue = item.badgeValue;
        self.accessoryView = self.badgeView;
    }
    else if ([item isKindOfClass:[ESSettingArrowItem class]]) // 箭头
    {
        self.accessoryView = self.arrow;
    }
    else if ([item isKindOfClass:[ESSettingSwitchItem class]]) // 开关
    {
        self.accessoryView = self.rightSwitch;
        // 设置打开状态
        ESSettingSwitchItem *switchItem = (ESSettingSwitchItem *)item;
        self.rightSwitch.on = switchItem.on;
    }
    else if([item isKindOfClass:[ESSettingLabelItem class]]) // 文字
    {
        self.accessoryView = self.arrow;
        ESSettingLabelItem *labelItem = (ESSettingLabelItem *)item;
        // 设置文字
        self.rightLabel.text = labelItem.text;
        // 根据文字计算尺寸
        self.rightLabel.size = [labelItem.text sizeWithFont:self.rightLabel.font maxW:MAXFLOAT];
    }
    else if ([item isKindOfClass:[ESSettingCheckItem class]]) // 打勾
    {
        ESSettingCheckItem *checkItem = (ESSettingCheckItem *)item;
        self.accessoryView = checkItem.on ? self.checkmark : nil;
    }
    else // 取消右边的内容
    {
        self.accessoryView = nil;
    }
    
    // 3. 右侧文字控件是否显示
    self.rightLabel.hidden = ![item isKindOfClass:[ESSettingLabelItem class]];
}

#pragma mark - init
/**
 *  根据样式初始化cell
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:16];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

#pragma mark - private
/**
 *  UISwitch监听事件
 */
- (void)switchChange:(UISwitch *)sender
{
    ESSettingSwitchItem *switchItem = (ESSettingSwitchItem *)self.item;
    switchItem.on = sender.on;
}

#pragma mark - super
/**
 *  调整子控件的位置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 距离标题的间距
    CGFloat distance = 10;
    // 调整子标题的x
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + distance;
    
    // 右侧文字frame
    self.rightLabel.frame = CGRectMake(self.accessoryView.x - self.rightLabel.width - 5, (ESBaseSettingViewCellH - self.rightLabel.height) / 2, self.rightLabel.width, self.rightLabel.height);
}

@end
//
//  ESBadgeView.m
//  sdfyy
//
//  Created by yh on 15/1/17.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESBadgeView.h"

@implementation ESBadgeView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 设置按钮字体
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        // 设置背景图片
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        // 设置按钮高度为背景图片的高度
         self.size = self.currentBackgroundImage.size;
        self.userInteractionEnabled = NO;
    }
    return self;
}

#pragma mark - setter方法
/**
 *  设置提醒数字
 */
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    int value = badgeValue.intValue;
    if (value == 0) // 没有值可以显示
    {
        self.hidden = YES;
    }
    else
    {
        self.hidden = NO;
    }
    
    // 设置按钮文字
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    // 根据文字计算尺寸
//    CGSize titleSize = [badgeValue sizeWithFont:self.titleLabel.font];
//    CGFloat bgW = self.currentBackgroundImage.size.width;
//    if (titleSize.width <= bgW) // 文字宽度小于背景图片宽度
//    {
//        self.width = bgW;
//    }
//    else // 文字宽度大于背景图片宽度
//    {
//        self.width = titleSize.width + 15;
//    }
}

@end
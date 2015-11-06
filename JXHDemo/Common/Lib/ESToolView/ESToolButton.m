//
//  ESToolButton.m
//  sdfyy
//
//  Created by yh on 15/1/26.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESToolButton.h"

@implementation ESToolButton

#pragma mark - setters
/**
 *  设置按钮选中
 */
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    // 重新渲染
    [self setNeedsDisplay];
}

#pragma mark - init
/**
 *  根据frame初始化
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 设置按钮文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
        // 设置正常状态下文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

#pragma mark - super
/**
 *  按钮重绘
 */
- (void)drawRect:(CGRect)rect
{
    if (self.selected)
    {
        // 按钮文字size
        CGSize size = [self.titleLabel.text sizeWithFont:self.titleLabel.font maxW:MAXFLOAT];
        // 横线高度
        CGFloat buttonH = 2;
        CGFloat buttonX = self.titleLabel.x;
        CGFloat buttonY = self.height - buttonH;
        CGFloat buttonW = size.width;
        // 横线frame
        CGRect frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        // 横线颜色
        [RGBColor(24, 166, 14) set];
        UIRectFill(frame);
    }
}

@end
//
//  ESToolView.m
//  sdfyy
//
//  Created by yh on 15/1/26.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

// 按钮之间的间距
CGFloat const ESToolButtonSpace = 10;

#import "ESToolView.h"
#import "ESToolButton.h"

@interface ESToolView ()

/**
 *  当前选中的按钮
 */
@property (nonatomic,weak) ESToolButton *selectedButton;

@end

@implementation ESToolView

#pragma mark - setters
/**
 *  设置按钮文字数组（创建按钮）
 */
- (void)setButtonNames:(NSArray *)buttonNames
{
    // 传入按钮名数组
    _buttonNames = buttonNames;
    // 按钮个数
    NSInteger count = buttonNames.count;
    // 按钮y
    CGFloat buttonY = 8;
    // 每个按钮宽度
    CGFloat buttonW = (self.width - (count + 1) * ESToolButtonSpace) / count;
    // 按钮高度(view高度减去一定距离)
    CGFloat buttonH = self.height - 12;
    // 创建按钮
    for (int i = 0; i < count; i++)
    {
        // 按钮文字
        NSString *title = buttonNames[i];
        // 创建按钮
        ESToolButton *button = [ESToolButton buttonWithType:UIButtonTypeCustom];
        CGFloat buttonX = ESToolButtonSpace + i * (buttonW + ESToolButtonSpace);
        // 设置frame
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        // 设置tag
        button.tag = i;
        // 正常状态下按钮文字
        [button setTitle:title forState:UIControlStateNormal];
        // 点击事件
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        // 默认选中第一个
        if (i == 0)
        {
            button.selected = YES;
            self.selectedButton = button;
        }
        // 添加到view中
        [self addSubview:button];
    }
}

#pragma mark - init
/**
 *  创建ESToolView
 */
+ (instancetype)toolView
{
    return [[self alloc] init];
}

/**
 *  根据frame创建
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 设置默认背景图片
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"buddy_header_bg"]];
    }
    return self;
}

#pragma mark - private
/**
 *  按钮点击
 */
- (void)click:(ESToolButton*)button
{
    if(self.selectedButton != button) // 点击的不是当前选中的按钮
    {
        self.selectedIndex = button.tag;
        
        // 取消当前按钮选中
        self.selectedButton.selected = NO;
        
        // 通知代理
        if ([self.delegate respondsToSelector:@selector(toolView:didSelectedButtonAtIndex:)])
        {
            [self.delegate toolView:self didSelectedButtonAtIndex:button.tag];
        }
        
        // 被点击的按钮设为选中状态
        button.selected = YES;
        // 被点击的按钮设为当前选中按钮
        self.selectedButton = button;
    }
}

@end
//
//  SectionHeaderView.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/23/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//
#define sectionMargin 10
#define sectionIconSize 20
#import "SectionHeaderView.h"
@interface SectionHeaderView()

@end

@implementation SectionHeaderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //设置按钮属性
        [self setButton];
    }
    return self;
}

/**
 *  设置按钮属性
 */
- (void)setButton {
    _isOpen = NO;
    //背景色
    self.backgroundColor = [UIColor whiteColor];
    // 文字颜色
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 指示图片
    [self setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    // 图片模式
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    // 禁止高亮
    self.adjustsImageWhenHighlighted = NO;
    // 添加点击事件
    [self addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    //添加下分割线
    UIImageView *underLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
    //贴图
    [underLine setImage:[UIImage imageNamed:@"line"]];
    //改变线的透明度
    [underLine setAlpha:0.3];
    [self addSubview:underLine];
}

/**
 *  点击
 */
- (void)clicked:(SectionHeaderView *)sender {
    //通知代理
    [_delegate sectionDidClicked:sender];
    //如果没展开，顺时针旋转90度
    if (!_isOpen) {
        [self.imageView setTransform:CGAffineTransformMakeRotation(M_PI_2)];
    }
    //如果展开了，逆时针旋转90度
    else {
        [self.imageView setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
    }
    //状态取反
    _isOpen = !_isOpen;
}

/**
 *  imageview位置尺寸自定义设置
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat w = 10;
    CGFloat x = (contentRect.size.height - w) / 2;
    return CGRectMake(25, x, w, w);
}

/**
 *  按钮标题位置设置
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(55, 0, contentRect.size.width, contentRect.size.height);
}

@end
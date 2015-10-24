//
//  SectionHeaderView.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/23/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//
#define sectionMargin 10
#define sectionIconSize 20
#define sectionHeaderH 40 //组头部的高度
#import "SectionHeaderView.h"

@implementation SectionHeaderView

/**
 *  创建一个按钮
 */
- (SectionHeaderView *)initWithIcon:(NSString *)icon andTitle:(NSString *)title {
    if (self == [super init]) {
        // 0.基本样式设置
        [self setHeaderView];
        // 1.初始关闭状态
        _isOpen = NO;
        // 2.指示图标
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(sectionMargin, sectionMargin, sectionIconSize, sectionIconSize)];
        [_icon setImage:[UIImage imageNamed:icon]];
        //不改变View中图片的尺寸，防止变形
        _icon.contentMode = UIViewContentModeCenter;
        // 添加图标
        [self addSubview:_icon];
        // 3.标题
        _title = [[UILabel alloc] initWithFrame:CGRectMake(2*sectionMargin+sectionIconSize, sectionMargin, 0, 0)];
        //文字
        [_title setText:title];
        //自适应尺寸
        [_title sizeToFit];
        //添加标题
        [self addSubview:_title];
        // 4.添加点击事件
        [self addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
/**
 *  基本样式设置
 */
- (void)setHeaderView {
    //尺寸
    [self setFrame:CGRectMake(0, 0, ApplicationW,sectionHeaderH)];
    //背景色
    self.backgroundColor = [UIColor whiteColor];
    //添加下分割线
    UIImageView *underLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
    //贴图
    [underLine setImage:[UIImage imageNamed:@"line"]];
    //改变线的透明度
    [underLine setAlpha:0.4];
    [self addSubview:underLine];
}

//+ (SectionHeaderView *)headerView {
//}
/**
 *  点击
 */
- (void)clicked:(UIButton *)sender {
    //通知代理
    [_delegate sectionDidClicked:sender];
    //如果没展开，逆时针旋转90度
    if (!_isOpen) {
        [_icon setTransform:CGAffineTransformMakeRotation(-90.0 * (M_PI/180.0))];
    }
    //如果展开了，顺时针旋转90度
    else {
        [_icon setTransform:CGAffineTransformMakeRotation(90.0 * (M_PI/180.0))];
    }
    //状态取反
    _isOpen = !_isOpen;
}
/**
 *  绘图函数
 */
- (void)drawRect:(CGRect)rect {
}


@end

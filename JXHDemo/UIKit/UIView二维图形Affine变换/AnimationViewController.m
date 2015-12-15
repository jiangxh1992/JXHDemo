//
//  AnimationViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 12/14/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController()

/**
 * 测试用button
 */
@property (nonatomic, strong)UIButton *button;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景色
    self.view.backgroundColor = RGBColor(230, 230, 230);
    // 设置按钮
    [self setButton];
}

/**
 *  设置按钮
 */
- (void)setButton {
    _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ApplicationW/2, 30)];
    _button.center = CGPointMake(ApplicationW/2, ApplicationH/3);
    _button.layer.cornerRadius = 3;
    _button.backgroundColor = [UIColor orangeColor];
    [_button setTitle:@"点我我会摇~" forState: UIControlStateNormal];
    [_button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

/**
 *  按钮点击
 */
- (void)click:sender {
    // UIView的layer
    CALayer *layer = [sender layer];
    // UIView的position
    CGPoint positionLayer = [layer position];
    // 左右晃动基点
    CGPoint left = CGPointMake(positionLayer.x-10, positionLayer.y);
    CGPoint right = CGPointMake(positionLayer.x+10, positionLayer.y);
    // 晃动动画定义
    CABasicAnimation * shakeAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 慢进慢出
    [shakeAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    // 动画起始点
    [shakeAnimation setFromValue:[NSValue valueWithCGPoint:left]];
    [shakeAnimation setToValue:[NSValue valueWithCGPoint:right]];
    // 自动反向
    [shakeAnimation setAutoreverses:YES];
    // 间隔时间
    [shakeAnimation setDuration:0.08];
    // 重复次数
    [shakeAnimation setRepeatCount:3];
    [layer addAnimation:shakeAnimation forKey:nil];
}

@end
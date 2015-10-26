//
//  TestViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/23/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(230, 230, 230);
    
    // 1.测试sizeToFit
    [self sizeToFit];
}
/**
 *  1.测试sizeToFit
 */
- (void)sizeToFit {
    /**
     *  有时候UIView的尺寸不好直接设置，需要根据内容来改变UIView的尺寸，这就需要使用sizeToFit方法。
     *  以UILabel为例，使用sizeToFit方法后，可以根据UILabel中字符串大小自动调整UILabel的大小
     *  UIButton使用sizeToFit方法，会根据button标题的大小自动调整UIButton的大小
     */
    //零尺寸UILabel
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    //设置中心
    label.center = CGPointMake(0, self.view.center.y);
    //label背景色，便于看其尺寸
    [label setBackgroundColor:[UIColor grayColor]];
    //label字体颜色
    label.textColor = [UIColor whiteColor];
    //label文字内容
    label.text = @"UILabel会根据我的长度变化大小";
    //sizeToFit
    [label sizeToFit];
    //显示label
    [self.view addSubview:label];
}

@end
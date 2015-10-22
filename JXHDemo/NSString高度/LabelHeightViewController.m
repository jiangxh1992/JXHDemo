//
//  LabelHeightViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/21/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//
#define labelW 300 //label的固定宽度
#define fontSize 20 //字体大小
#import "LabelHeightViewController.h"

@implementation LabelHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(230, 230, 230);
    // 1.测试的一段文字：
    NSString *text = @"秋叶黄,秋叶黄,我深深的沉醉其中,摇摆的叶片,枯黄着也是秋天,飘落着也是秋天;秋叶黄,秋叶黄,你随风悄悄的散去,枯萎的树枝,下着雨也是秋天,吹着风也是秋天.";
    
    // 2.计算文字在label中的高度
    // 就用这两个options枚举参数吧，我也不知道为啥
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    // labelW是段落的固定宽度；CGFLOAT_MAX固定用这个；attributes按照下面的语句fontSize是字体的大小
    // >IOS7
    CGFloat labelH = [text boundingRectWithSize:CGSizeMake(labelW, CGFLOAT_MAX) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.height;
    // <IOS7
//    CGFloat labelH = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(labelW, CGFLOAT_MAX)].height;
    // 打印计算的高度看一下
    NSLog(@"文字段落高度为：%f",labelH);
    
    // 3.用于显示文字的UILabel,固定宽度为300
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, labelW, labelH)];
    // 文字行数
    label.numberOfLines = labelH/fontSize;
    // 显示文字
    label.text = text;
    // label背景色
    label.backgroundColor = [UIColor greenColor];
    // 显示label
    [self.view addSubview:label];
}

@end
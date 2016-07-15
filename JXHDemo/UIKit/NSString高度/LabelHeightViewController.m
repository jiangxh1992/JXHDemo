//
//  LabelHeightViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/21/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//
#define labelW 300 //label的固定宽度
#define fontSize 20 //字体大小
#define lingSpace 5 //行间距
#import "LabelHeightViewController.h"

@implementation LabelHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(230, 230, 230);
    
    /** 1.测试的一段文字： **/
    NSString *text = @"秋叶黄,秋叶黄,我深深的沉醉其中,摇摆的叶片,枯黄着也是秋天,飘落着也是秋天;秋叶黄,秋叶黄,你随风悄悄的散去,枯萎的树枝,下着雨也是秋天,吹着风也是秋天.";
    
    /** 2.计算文字在label中的高度 **/
    // 就用这两个options枚举参数吧，我也不知道为啥
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    // labelW是段落的固定宽度；CGFLOAT_MAX固定用这个；attributes按照下面的语句fontSize是字体的大小
    CGFloat labelH;
    if (IOS7) {
        labelH = [text boundingRectWithSize:CGSizeMake(labelW, CGFLOAT_MAX) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.height;
    }else {
        labelH = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(labelW, CGFLOAT_MAX)].height;
    }
    // 打印计算的高度看一下
    NSLog(@"文字段落高度为：%f",labelH);
    //实际行数
    NSInteger lineNum = labelH/fontSize;
    
    /** 3.定义段落样式 **/
    NSMutableParagraphStyle *paragraphStyle = [[ NSMutableParagraphStyle alloc ] init];
    //文字对齐方式
    paragraphStyle.alignment = NSTextAlignmentJustified;
    //段落首字符缩进两个字
    paragraphStyle.firstLineHeadIndent = 2*fontSize;
    //每行行首缩进
    paragraphStyle.headIndent = 10;
    //行间距
    paragraphStyle.lineSpacing = lingSpace;
    //属性字典,包括前景字体颜色和段落属性
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor redColor],NSParagraphStyleAttributeName:paragraphStyle};
    //属性字符串
    NSAttributedString *attributedText = [[ NSAttributedString alloc ] initWithString : text attributes :attributes];
    /** 4.用于显示文字的UILabel,固定宽度为300,高度为：段落文字高度+所有行间距 **/
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 300, labelH+lineNum*lingSpace)];
    // 文字行数设置为0
    label1.numberOfLines = 0;
    // label背景色
    label1.backgroundColor = [UIColor greenColor];
    label1.attributedText = attributedText;
    // 显示label
    [self.view addSubview:label1];
}

@end
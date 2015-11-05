//
//  UIAlertView+DIY.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/28/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//
#import "UIAlertView+DIY.h"
#define fontSize 15
@implementation UIAlertView (DIY)

/**
 *  添加子视图
 */
- (void) addUIView: (UIView *)view {
    if (iOS7) {
        [self setValue:view forKey:@"accessoryView"];
    }else{
        [self addSubview:view];
    }
    //隐藏提示框的原有内容
    self.message = @"";
}
/**
 *  添加居左对齐的UILabel
 */
- (void) addLeftAlignmentLabel:(UILabel *)label {
    /** 2.计算文字在label中的高度 **/
    // 就用这两个options枚举参数吧，我也不知道为啥
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    // labelW是段落的固定宽度；CGFLOAT_MAX固定用这个；attributes按照下面的语句fontSize是字体的大小
    // >IOS7
    CGFloat labelH = [label.text boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.height;
    // <IOS7
    //CGFloat labelH = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(labelW, CGFLOAT_MAX)].height;
    // 打印计算的高度看一下
    NSLog(@"文字段落高度为：%f",labelH);
    //实际行数
    NSInteger lineNum = labelH/fontSize;
    //设置label的高度
    [label setFrame:CGRectMake(0, 0, 300, labelH+20)];
    //行数设置为0
    label.numberOfLines = 0;
    
    //定义段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:5.0];
    //段落文字溢出隐藏方式
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    //段落首字符缩进两个字
    paragraphStyle.firstLineHeadIndent = 2*15;
    //每行行首缩进
    paragraphStyle.headIndent = 10;
    //左对齐
    paragraphStyle.alignment = NSTextAlignmentJustified;
    //属性字典
    NSDictionary *attributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:paragraphStyle};
    //定义格式化属性文字
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text attributes:attributes];
    //设置label的attributedText
    //label.attributedText = attributedString;
    //把原普通text清空
    //label.text = @"";
    //将label添加到AlertView中
    [self addLabel:label];
}

/**
 *  添加一个完全自定义的UILabel
 */
- (void) addLabel:(UILabel *)label {
    if (iOS7) {
        [self setValue:label forKey:@"accessoryView"];
    }else{
        [self addSubview:label];
    }
    //隐藏提示框的原有内容
    self.message = @"";
}

@end
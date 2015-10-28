//
//  UIAlertView+DIY.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/28/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//
#import "UIAlertView+DIY.h"

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
    //计算文字段落的尺寸
    CGSize size = [label.text sizeWithFont:label.font maxW:240];
    //设置label的高度
    [label setFrame:CGRectMake(0, 0, size.width, size.height+20)];
    //行数
    label.numberOfLines = 0;
    //文字左对齐
    label.textAlignment = NSTextAlignmentLeft;
    //取出label的text并改写成attributedText
    //NSString *attributedText = label.text;
    //定义段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:5.0];
    //段落文字溢出隐藏方式
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    //段落前间距
    [paragraphStyle setParagraphSpacingBefore:20.0];
    
    //定义格式化属性文字
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    //为每一个字添加属性
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, label.text.length)];
    //设置label的attributedText
    label.attributedText = attributedString;
    //把原普通text清空
    label.text = @"";
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
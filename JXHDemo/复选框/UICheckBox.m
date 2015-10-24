//
//  UICheckBox.m
//  demo
//
//  Created by txbydev3 on 15/9/23.
//  Copyright © 2015年 txbydev3. All rights reserved.
//
#import "UICheckBox.h"

@implementation UICheckBox
/**
 *初始化checkbox按钮
 */
- (UICheckBox *)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        //开始的时候设置复选框是未选中的
        self.selected = NO;
        _isChecked = NO;
        //设置checkobx的监听事件
        [self addTarget:self action:@selector(checkboxClick) forControlEvents:UIControlEventTouchUpInside];
        return self;
    }
    return nil;
}
/**
 *  设置未选中图片
 */
- (void)setNormalImage:(UIImage*)normalImage {
    [self setImage:normalImage forState:UIControlStateNormal];
}
/**
 *  设置选中图片
 */
- (void)setSelectedImage:(UIImage*)selectedImage {
    [self setImage:selectedImage forState:UIControlStateSelected];
}
/**
 *  设置图片
 */
- (void)setImage:(UIImage*)normalImage andSelectedImage:(UIImage*)selectedImage {
    [self setNormalImage:normalImage];
    [self setSelectedImage:selectedImage];
}

/**
 *  用字符串设置未选中图片
 */
- (void)setNormalImageWithName:(NSString*)normalImageName {
    [self setNormalImage:[UIImage imageNamed:normalImageName]];
}
/**
 *  用字符串设置选中图片
 */
- (void)setSelectedImageWithName:(NSString*)selectedImageName {
    [self setSelectedImage:[UIImage imageNamed:selectedImageName]];
}
/**
 *  用字符串设置图片
 */
- (void)setImageWithName:(NSString*)normalImageName andSelectedName:(NSString*)selectedImageName {
    [self setNormalImageWithName:normalImageName];
    [self setSelectedImageWithName:selectedImageName];
}

/**
 *按钮点击事件，点击后取反按钮状态
 */
-(void)checkboxClick {
    //取反复选框状态，通过取按钮的selected属性可以判断复选框当前有没有选中
    self.selected = !self.selected;
    _isChecked = self.selected;
    //后台打印调试
    if (self.selected) {
        NSLog(@"1");
    }else{
        NSLog(@"0");
    }
}

@end
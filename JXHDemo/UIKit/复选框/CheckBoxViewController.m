//
//  CheckBoxViewController.m
//  demo
//
//  Created by txbydev3 on 15/10/6.
//  Copyright © 2015年 txbydev3. All rights reserved.
//
#define boxSize 50 //复选框尺寸
#import "CheckBoxViewController.h"
#import "UICheckBox.h"

@interface CheckBoxViewController ()

@end

@implementation CheckBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    self.title = @"复选框";
    //背景
    self.view.backgroundColor = RGBColor(230, 230, 230);
    //复选框
    UICheckBox *checkbox = [[UICheckBox alloc] initWithFrame:CGRectMake(ApplicationW/2 - boxSize/2, ApplicationH/3, boxSize, boxSize)];
    //设置复选框图片
    [checkbox setImageWithName:@"checkbox_off" andSelectedName:@"checkbox_on"];
    [self.view addSubview:checkbox];
}
@end

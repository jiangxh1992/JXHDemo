//
//  MYViewController.m
//  demo
//
//  Created by txbydev3 on 15/9/11.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//

#import "MYViewController.h"

@implementation MYViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"走访纪录";
    //设置右侧系统按钮
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                                                              target:nil
                                                                              action:nil];
    
    self.navigationItem.rightBarButtonItem = rightBtn;
    //设置左侧返回按钮
    UILabel *backLabel = [[UILabel alloc] init];
    backLabel.text = @"返回";
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                                             target:nil
                                                                             action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = backBtn;
//    //顶部导航条的frame设置
//    self.topBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,44)];
//    //顶部导航条的背景
//    [self.topBarView setBackgroundColor:[UIColor blueColor]];
//    //添加顶部导航条到UIViewController的view中
//    [self.view addSubview:self.topBarView];
//    //返回按钮
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button setTitle:@"返回" forState:UIControlStateNormal];//按钮标题
//    button.backgroundColor = [UIColor whiteColor];//按钮颜色
//    button.frame = CGRectMake(0, 0, 100, 44);//按钮frame
//    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.topBarView addSubview:button];//添加按钮到导航条
}
//返回按钮响应处理函数
-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end

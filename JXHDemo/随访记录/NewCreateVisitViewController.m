//
//  NewCreateVisitViewController.m
//  demo
//
//  Created by txbydev3 on 15/9/14.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//

#import "NewCreateVisitViewController.h"

@interface NewCreateVisitViewController ()

@end

@implementation NewCreateVisitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.导航条设置
    [self setNavBar];
    //2.设置内容
    [self setContent];
}
/**
 *1.导航条设置
 */
- (void)setNavBar {
    //1.创建一个导航条并初始化rect
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, 74)];
    //1.1导航条背景
    navigationBar.barTintColor = RGBColor(18, 96, 150);
    //1.2导航条控件颜色
    navigationBar.tintColor = [UIColor whiteColor];
    //1.3导航栏标题颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navigationBar setTitleTextAttributes:textAttrs];
    
    //1.4创建UINavigationItem
    //导航条标题
    UINavigationItem * navigationBarTitle = [[UINavigationItem alloc] initWithTitle:@"新建随访"];
    [navigationBar pushNavigationItem: navigationBarTitle animated:YES];
    [self.view addSubview: navigationBar];
    //返回按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] landscapeImagePhone:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    //发送按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:nil];
    //设置barbutton
    navigationBarTitle.leftBarButtonItem = leftItem;
    navigationBarTitle.rightBarButtonItem = rightItem;
    [navigationBar setItems:[NSArray arrayWithObject: navigationBarTitle]];
}
/**
 *2.设置内容
 */
- (void)setContent {
    //左右边距
    NSInteger margin = 30;
    //字体的高
    NSInteger txtH = 20;
    //top
    NSInteger top = 74+50;
    //1.诊断
    UILabel *dignoseLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, top, 3*txtH, txtH)];
    [dignoseLabel setText:@"诊断:"];
    [self.view addSubview:dignoseLabel];
    
    //2.诊断
    UITextView *dignoseTextView = [[UITextView alloc] initWithFrame:CGRectMake(margin, dignoseLabel.frame.origin.y+2*txtH, ApplicationW-2*txtH, 3*txtH)];
    dignoseTextView.layer.borderWidth = 1;
    dignoseTextView.layer.borderColor = [[UIColor grayColor]CGColor];
    dignoseTextView.layer.cornerRadius = 5;
    [self.view addSubview:dignoseTextView];
    
    //3.医生
    UILabel *doctorLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin,dignoseTextView.frame.origin.y+dignoseTextView.frame.size.height+margin, ApplicationW-2*txtH, txtH)];
    [doctorLabel setText:@"医生：胸外科       黄海涛"];
    [self.view addSubview:doctorLabel];
    
    //4.复诊内容
    UILabel *reCheckLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, doctorLabel.frame.origin.y+doctorLabel.frame.size.height+2*margin, ApplicationW-2*txtH, txtH)];
    [reCheckLabel setText:@"复诊内容"];
    [self.view addSubview:reCheckLabel];
    
    //5.复诊内容
    UITextField *reCheckContent = [[UITextField alloc] initWithFrame:CGRectMake(margin, reCheckLabel.frame.origin.y+reCheckLabel.frame.size.height+margin, ApplicationW-2*txtH, 2*txtH)];
    reCheckContent.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:reCheckContent];
    
    //6.复诊时间
    UILabel *reCheckTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, reCheckContent.frame.origin.y+reCheckContent.frame.size.height+2*margin, 5*txtH, txtH)];
    [reCheckTimeLabel setText:@"复诊时间："];
    UITextField *reCheckTimeContent = [[UITextField alloc] initWithFrame:CGRectMake(margin+reCheckTimeLabel.frame.size.width, reCheckTimeLabel.frame.origin.y, ApplicationW-2*txtH-reCheckTimeLabel.frame.size.width, txtH)];
    reCheckTimeContent.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:reCheckTimeLabel];
    [self.view addSubview:reCheckTimeContent];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

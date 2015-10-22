//
//  VisitViewController.m
//  demo
//
//  Created by txbydev3 on 15/9/10.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//

#import "VisitViewController.h"

@interface VisitViewController ()

@end

@implementation VisitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.frame = [UIScreen mainScreen].bounds;
    //self.view.backgroundColor = [UIColor colorWithRed:240 green:239 blue:237 alpha:1.0];
    //创建一个导航条
    //NavigationBar *navBar = [NavigationBar navigationBar];
    //navBar.frame = CGRectMake(0, 0, screenWidth, 70);
    //将导航条添加到根view中
    //[self.view addSubview:navBar];
    
    
    //导航栏
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, 70)];
    //导航栏的背景颜色
    [navigationBar setBarTintColor:[UIColor colorWithRed:13/255.0 green:117/255.0 blue:168/255.0 alpha:1.0]];
    
    //创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    //设置导航栏的标题内容
    [navigationItem setTitle:@"随访记录"];
    
    //创建一个左边按钮,是图片的和文字的组合按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //追加返回按钮图片,覆盖了文字？
    /*
     UIImage *backImg = [UIImage imageNamed:@"back.png"];
     [leftButton setImage:backImg];
     */
    
    //创建一个右边按钮，是图片按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"复诊" style:UIBarButtonItemStylePlain target:self action:@selector(write)];
    
    //把左右两个按钮添加到导航栏集合中去
    [navigationItem setBackBarButtonItem:backButton];
    [navigationItem setRightBarButtonItem:rightButton];
    
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    [self.view addSubview:navigationBar];
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

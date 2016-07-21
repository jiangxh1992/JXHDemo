//
//  TabNavController.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 16/7/21.
//  Copyright © 2016年 Jiangxh. All rights reserved.
//

#import "TabNavController.h"

@interface TabNavController ()

@end

@implementation TabNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 顶部导航栏的背景色
    self.navigationBar.barTintColor = RGBColor(28, 190, 164);
    // 导航栏标题文字颜色和大小
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

@end
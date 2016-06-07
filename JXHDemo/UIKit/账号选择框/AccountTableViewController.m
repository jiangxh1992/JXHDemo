//
//  AccountTableViewController.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 6/7/16.
//  Copyright © 2016 Jiangxh. All rights reserved.
//

#import "AccountTableViewController.h"

@interface AccountTableViewController ()

@end

@implementation AccountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景透明
    self.view.backgroundColor = [UIColor clearColor];
    // 清除多余的分割线
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    // 默认关闭下拉列表
    _isOpen = NO;
}

// 分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 每个分区cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 展开与隐藏账号列表
    if(_isOpen)
        return _accountSource.count;
    else
        return 0;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *specialId = @"id";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:specialId];
    // 添加数据源
    cell.textLabel.text = [_accountSource objectAtIndex:indexPath.row];
    return cell;
}

// cell选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 通知代理
    [_delegate selectedCell:indexPath.row];
}

@end
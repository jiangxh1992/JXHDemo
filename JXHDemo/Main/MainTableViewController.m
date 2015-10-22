//
//  MainTableViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/21/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//

#import "MainTableViewController.h"
#import "MapViewController.h"
#import "LabelHeightViewController.h"
#import "OpenWebViewController.h"
#import "CheckBoxViewController.h"
#import "AlertViewController.h"
#import "CustomCalendarViewController.h"
#import "TimerShaftTableViewController.h"
#import "VisitTableTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 导航栏设置
    [self setNav];
    // table设置
    [self setTableView];
    //视图名称
    _viewNames = [[NSArray alloc] initWithObjects:@"地图", @"Label高度计算", @"UIWebView", @"复选框", @"左对齐alertview", @"日历", @"时间轴", @"随访记录", nil];
}
/**
 *  导航栏设置
 */
- (void)setNav {
    // 标题
    self.title = @"蒋信厚的Demo";
    // 导航条按钮组件
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(selector)];
    // 导航栏背景色
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    // 导航栏按钮组件的颜色
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
}
/**
 *  tableview设置
 */
- (void)setTableView {
    // tableview背景色
    self.tableView.backgroundColor = RGBColor(230, 230, 230);
    //header高度
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, 20)];
    // tableview尾部视图设置，这样用一个不占空间的UIView初始化可以清除尾部多余空格
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
#pragma mark - Table view data source
/**
 *  行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _viewNames.count;
}
/**
 *  cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    // 1.cell名字
    cell.textLabel.text = [_viewNames objectAtIndex:indexPath.row];
    // 2.分割线清偏移
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    //分割线清边界
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    //清除父边界
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    // 3.cell颜色
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
/**
 *  点击cell跳转
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // 地图
        MapViewController *mapVC = [[MapViewController alloc] init];
        [self.navigationController pushViewController:mapVC animated:YES];
    }
    if (indexPath.row == 1) {
        // NSString高度计算
        LabelHeightViewController *labelVC = [[LabelHeightViewController alloc] init];
        [self.navigationController pushViewController:labelVC animated:YES];
    }
    if (indexPath.row == 2) {
        // 打开网页
        OpenWebViewController *webVC = [[OpenWebViewController alloc] init];
        [self.navigationController pushViewController:webVC animated:YES];
    }
    if (indexPath.row == 3) {
        // 复选框
        CheckBoxViewController *checkBoxVC = [[CheckBoxViewController alloc] init];
        [self.navigationController pushViewController:checkBoxVC animated:YES];
    }
    if (indexPath.row == 4) {
        // 左对齐alertveiw
        AlertViewController *alertVC = [[AlertViewController alloc] init];
        [self.navigationController pushViewController:alertVC animated:YES];
    }
    if (indexPath.row == 5) {
        // 日历
        CustomCalendarViewController *calendar = [[CustomCalendarViewController alloc] init];
        [self.navigationController pushViewController:calendar animated:YES];
    }
    if (indexPath.row == 6) {
        // 时间轴
        TimerShaftTableViewController *timerVC = [[TimerShaftTableViewController alloc] init];
        [self.navigationController pushViewController:timerVC animated:YES];
    }
    if (indexPath.row == 7) {
        // 随访记录
        VisitTableTableViewController *visitVC = [[VisitTableTableViewController alloc] init];
        [self.navigationController pushViewController:visitVC animated:YES];
    }
}

@end
//
//  MyDemoViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import "MyDemoViewController.h"
#import "TimerShaftTableViewController.h"
#import "CustomCalendarViewController.h"

@interface MyDemoViewController ()

@end

@implementation MyDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *mulNames = [[NSMutableArray alloc] init];
    // cell的名称
    NSArray *names = @[@"时间轴", @"日历"];
    for (NSString *name in names) {
        ESListItem *item = [[ESListItem alloc] init];
        item.title = name;
        [mulNames addObject:item];
    }
    // 设置数据源
    self.items = mulNames;
}

/**
 *  cell点击
 */
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.时间轴
    TimerShaftTableViewController *timeVC = [[TimerShaftTableViewController alloc] init];
    // 2.日历
    CustomCalendarViewController *calendarVC = [[CustomCalendarViewController alloc] init];
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:timeVC animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:calendarVC animated:YES];
            
        default:
            break;
    }
}

@end
//
//  MyDemoViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//
#import "MyDemoViewController.h"
#import "CustomCalendarViewController.h"
#import "SplitTableViewController.h"
#import "MapViewController.h"

@interface MyDemoViewController ()

/**
 *  类名数组
 */
@property (nonatomic, strong)NSArray *classNames;

@end

@implementation MyDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *mulNames = [[NSMutableArray alloc] init];
    // cell的名称
    _classNames = @[@"CustomCalendarViewController", @"SplitTableViewController", @"MapViewController"];
    for (NSString *name in _classNames) {
        ESListItem *item = [[ESListItem alloc] init];
        item.title = name;
        [mulNames addObject:item];
    }
    // 设置数据源
    self.items = mulNames;
}

/**
 *  cell点击跳转到控制器
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取出类名
    Class ClassName = NSClassFromString(_classNames[indexPath.row]);
    // 跳转到控制器
    [self.navigationController pushViewController:[[ClassName alloc] init] animated:YES];
}

@end
//
//  FoundationViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import "FoundationViewController.h"

@interface FoundationViewController ()

/**
 *  类名数组
 */
@property (nonatomic, strong)NSArray *classNames;

@end

@implementation FoundationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Foundation";
    // cell的名称
    _classNames = @[@"TestViewController", @"PlistViewController", @"AudioViewController"];
    //设置模型数据
    NSMutableArray *mulItems = [[NSMutableArray alloc] init];
    for (NSString *name in _classNames) {
        ESListItem *item = [[ESListItem alloc] init];
        item.title = name;
        [mulItems addObject:item];
    }
    // 设置数据源
    self.items = mulItems;
}

/**
 *  点击cell跳转
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取出类名
    Class ClassName = NSClassFromString(_classNames[indexPath.row]);
    // 跳转到控制器
    [self.navigationController pushViewController:[[ClassName alloc] init] animated:NO];
}

@end

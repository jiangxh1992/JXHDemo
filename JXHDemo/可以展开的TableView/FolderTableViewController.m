//
//  FolderTableViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/23/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//
#define sectionHeaderH 40 //组头部的高度
#import "FolderTableViewController.h"
#import "SectionHeaderView.h"

@interface FolderTableViewController ()<SectionHeaderDelegate>

@end

@implementation FolderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //表格基本设置
    self.title = @"可展开的TableView";
    //清除底部多余cell
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    //变量初始化
    [self initValue];
}

/**
 *  变量初始化
 */
- (void)initValue {
    //初试化标题数组假数据
    _titles = [[NSArray alloc] initWithObjects:@"抗微生物药物", @"抗寄生虫病药", @"镇痛药", @"麻醉用药物", @"维生素及矿物质缺乏", @"营养治疗药", @"激素及内分泌药", @"调节免疫功能药", nil];
    //状态数组
    _isOpen = [[NSMutableArray alloc] initWithCapacity:_titles.count];
    for (int i = 0; i<_titles.count; i++) {
        NSNumber *number = [NSNumber numberWithBool:NO];
        [_isOpen addObject:number];
    }
}

#pragma mark - 组设置
/**
 *  多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titles.count;
}
/**
 *  section header的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return sectionHeaderH;
}
/**
 *  section header的视图
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //section头部视图
    SectionHeaderView *sectionHeader = [[SectionHeaderView alloc] initWithIcon:@"arrow" andTitle:[_titles objectAtIndex:section]];
    //为headerview打上tag
    [sectionHeader setTag:section];
    //代理
    sectionHeader.delegate = self;
    return sectionHeader;
}
/**
 *  实现代理，sectionheader 点击
 */
- (void)sectionDidClicked:(UIButton *)sender {
    //取得相应section的展开状态并取反
    BOOL isOpen = ![[_isOpen objectAtIndex:sender.tag] boolValue];
    //转化成对象
    NSNumber *number = [NSNumber numberWithBool:isOpen];
    //取反状态
    [_isOpen setObject:number atIndexedSubscript:sender.tag];
    [self.tableView reloadData];
}

#pragma mark - 组内行设置
/**
 *  每组多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[_isOpen objectAtIndex:section] boolValue]) {
        return 5;
    }else {
        return 0;
    }
}
/**
 *  cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
//    if (nil == cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
    //cell文字标题
    cell.textLabel.text = @"item";
    //cell颜色
    cell.backgroundColor = RGBColor(230, 230, 230);
    return cell;
}

@end
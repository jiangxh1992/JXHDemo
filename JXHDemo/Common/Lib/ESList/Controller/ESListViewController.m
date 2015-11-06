//
//  ESListViewController.m
//  sdfyy
//
//  Created by yh on 15/1/31.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESListViewController.h"
#import "ESListCell.h"
#import "ESListCellFrame.h"

@interface ESListViewController ()

/**
 *  控件frame模型数组
 */
@property (nonatomic, strong) NSArray *cellFrames;

@end

@implementation ESListViewController

#pragma mark - setters
/**
 *  设置数据模型数组,并刷新表格
 */
- (void)setItems:(NSArray *)items
{
    _items = items;
    // 创建一个动态数组添加遍历转换后的模型数据
    NSMutableArray *arrayM = [NSMutableArray array];
    for (ESListItem *item in items)
    {
        ESListCellFrame *frame = [[ESListCellFrame alloc] init];
        frame.item = item;
        [arrayM addObject:frame];
    }
    self.cellFrames = arrayM;
    // 刷新表格
    [self.tableView reloadData];
}

#pragma mark - lifecycle
/**
 *  视图加载完成
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置表格属性
    [self setup];
}

#pragma mark - private
/**
 *  设置表格属性
 */
- (void)setup
{
    // 1. 设置分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    // 清除父类UIEdgeInsets
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 2. 设置透明头部视图，作为表格与父视图的间隔空隙
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, 0, self.view.width, CellMargin);
    header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = header;
    // 3.清除底部多余表格
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableViewDataSource
/**
 *  多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellFrames.count;
}

/**
 *  cell显示内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 创建cell
    static NSString *CellIdentifier = @"ESListCell";
    ESListCell *cell = [ESListCell yhcellWithTableView:tableView classString:CellIdentifier];
    // 2. 传递模型
    cell.cellFrame = self.cellFrames[indexPath.row];
    // 3. 分割线清偏移
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    //    分割线清边界（没啥变化）
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    //    清除父边界
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
        
    }
    return cell;
}

/**
 *  每一行高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellFrames[indexPath.row] cellHeight];
}

#pragma mark - UITabelViewDelegate
/**
 *  选中某一行
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
//
//  ESTableViewController.m
//  sdfyy
//
//  Created by yh on 15/2/9.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESTableViewController.h"
#import "ESCell.h"

@interface ESTableViewController () <ESCellDelegate>

@end

@implementation ESTableViewController

#pragma mark - getters
/**
 *  获取所有组数据模型
 */
- (NSMutableArray *)groups
{
    if (!_groups)
    {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

#pragma mark - setters
/**
 *  设置section之间的距离
 */
- (void)setSctionMargin:(ESTableViewSectionMargin)sctionMargin
{
    if (!IOS7) return;
    CGFloat margin = sctionMargin ? 20 : 10;
    
    // 设置tableView属性
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = margin;
    self.tableView.contentInset = UIEdgeInsetsMake(margin - 35, 0, 0, 0);
}

#pragma mark - lifecycle
/**
 *  屏蔽tableView的样式
 */
- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

/**
 *  视图加载完成
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置section之间的距离
    [self setSctionMargin:ESTableViewSectionMarginSmall];
}

#pragma mark - Table view data source
/**
 *  有多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

/**
 *  有多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ESGroup *group = self.groups[section];
    return group.items.count;
}

/**
 *  每一行内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 创建cell
    static NSString *CellIdentifier = @"ESCell";
    ESCell *cell = (ESCell *)[UITableViewCell cellWithTableView:tableView classString:CellIdentifier];
    
    // 2. 传递模型
    ESGroup *group = self.groups[indexPath.section];
    cell.cellFrame = group.items[indexPath.row];
    
    // 3. 设置背景
    [cell setBgAtIndexPath:indexPath countInSection:group.items.count];
    
    // 4. 设置代理（如果是日期选择控件或下拉选择控件）
    ESItem *item = cell.cellFrame.item;
    if ([item isKindOfClass:[ESDateItem class]] || [item isKindOfClass:[ESPickerItem class]])
    {
        cell.delegate = self;
    }
    
    return cell;
}

/**
 *  尾部文字
 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ESGroup *group = self.groups[section];
    return group.footer;
}

/**
 *  头部文字
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ESGroup *group = self.groups[section];
    return group.header;
}

/**
 *  每一行高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 对应的组
    ESGroup *group = self.groups[indexPath.section];
    // 对应的行
    ESCellFrame *cellFrame = group.items[indexPath.row];
    
    return cellFrame.cellHeight;
}

#pragma mark - Table view delegate
/**
 *  选中某一行
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 取出模型
    ESGroup *group = self.groups[indexPath.section];
    ESCellFrame *cellFrame = group.items[indexPath.row];
    
    // 成为第一响应者（如果是输入框或日期选择控件或下拉选择控件）
    ESItem *item = cellFrame.item;
    if ([item isKindOfClass:[ESFieldItem class]] ||[item isKindOfClass:[ESDateItem class]] || [item isKindOfClass:[ESPickerItem class]])
    {
        // 设置输入框为第一响应者
        ESCell *cell = (ESCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirst];
    }
}

#pragma mark - ESCellDelegate
/**
 *  刷新表格
 */
- (void)cellWillReload:(ESCell *)cell
{
    [self.tableView reloadData];
}
@end
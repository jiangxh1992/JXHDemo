//
//  ESBaseSettingViewController.m
//  sdfyy
//
//  Created by yh on 15/1/17.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESBaseSettingViewController.h"
#import "ESSettingCell.h"

@interface ESBaseSettingViewController ()

@end

@implementation ESBaseSettingViewController

#pragma mark -- getters
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
- (void)setSctionMargin:(ESBaseSettingSectionMargin)sctionMargin
{
    if (!IOS7) return;
    CGFloat margin = sctionMargin ? 20 : 10;
    
    // 设置tableView属性
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = margin;
    self.tableView.contentInset = UIEdgeInsetsMake(margin - 35, 0, 0, 0);
}

#pragma mark - init
/** 
 *  屏蔽tableView的样式
 */
- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

#pragma mark - lifecycle
/**
 *  视图加载完成
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置section之间的距离
    [self setSctionMargin:ESBaseSettingSectionMarginSmall];
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
    ESSettingGroup *group = self.groups[section];
    return group.items.count;
}

/**
 *  每一行内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 创建cell
    static NSString *CellIdentifier = @"ESSettingCell";
    ESSettingCell *cell = (ESSettingCell *)[UITableViewCell yhcellWithTableView:tableView classString:CellIdentifier];
    
    // 2. 传递模型
    ESSettingGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    
    // 3. 设置背景
    [cell yhsetBgAtIndexPath:indexPath countInSection:group.items.count];
    
    return cell;
}

/**
 *  尾部文字
 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ESSettingGroup *group = self.groups[section];
    return group.footer;
}

/**
 *  头部文字
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ESSettingGroup *group = self.groups[section];
    return group.header;
}

/**
 *  每一行高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ESBaseSettingViewCellH;
}

#pragma mark - Table view delegate
/**
 *  选中某一行
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 1. 取出模型
    ESSettingGroup *group = self.groups[indexPath.section];
    ESSettingItem *item = group.items[indexPath.row];
    
    // 1. 如果是打勾
    if ([item isKindOfClass:[ESSettingCheckItem class]]) // 打勾
    {
        ESSettingCheckItem *checkItem = (ESSettingCheckItem *)item;
        if (checkItem.on) return; // 如果点击的这个cell没有打勾才去改变状态。否则不改变
        
        // 循环所有item
        [group.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
            if (![obj isKindOfClass:[ESSettingCheckItem class]]) return;
            [obj setOn:[obj isEqual:item]];
        }];
        // 刷新表格
        [self.tableView reloadData];
    }
    
    // 2. 判断有没有要跳转的控制器
    if (item.destClass)
    {
        // 创建目标控制器
        UIViewController *vc = [[item.destClass alloc] init];
        // 设置标题
        vc.title = item.title;
        // 跳转到目标控制器
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    // 3. 判断有没有操作
    if (item.operation)
    {
        item.operation();
    }
}

@end
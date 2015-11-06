//
//  UITableViewCell+Extension.h
//  sdfyy
//
//  Created by yh on 15/1/15.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (YH)

/**
 *  创建一个可重用的cell
 *
 *  @param tableView  UITableView
 *  @param className  要创建的cell类名
 *  @param identifier 可重用标识符
 */
+ (instancetype)yhcellWithTableView:(UITableView *)tableView classString:(NSString *)className identifier:(NSString *)identifier;

/**
 *  创建一个可重用的cell(默认用类名当可重用标识符)
 *
 *  @param tableView  UITableView
 *  @param className  要创建的cell类名
 *  @param identifier 可重用标识符
 */
+ (instancetype)yhcellWithTableView:(UITableView *)tableView classString:(NSString *)className;

/**
 *  设置cell背景
 *
 *  @param indexPath  cell在表格中的位置
 *  @param count      cell所在section中的cell个数
 */
- (void)yhsetBgAtIndexPath:(NSIndexPath *)indexPath countInSection:(NSUInteger)count;

@end
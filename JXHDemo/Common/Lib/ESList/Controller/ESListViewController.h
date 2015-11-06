//
//  ESListViewController.h
//  sdfyy
//
//  Created by yh on 15/1/31.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  普通UITableView父类(一个标题，一个子标题)

#import <UIKit/UIKit.h>
#import "ESListItem.h"

@interface ESListViewController : UITableViewController

/**
 *  模型数组
 */
@property (nonatomic, strong) NSArray *items;

@end
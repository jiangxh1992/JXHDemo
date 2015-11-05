//
//  FolderTableViewController.h
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/23/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//  可折叠section的表格

#import <UIKit/UIKit.h>

@interface FolderTableViewController : UITableViewController

/**
 *  记录section的展开状态
 */
@property (nonatomic)NSMutableArray *isOpen;
/**
 *  记录section的标题数组
 */
@property (nonatomic)NSArray *titles;

@end
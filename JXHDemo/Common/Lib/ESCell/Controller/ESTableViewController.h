//
//  ESTableViewController.h
//  sdfyy
//
//  Created by yh on 15/2/9.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  文本、输入框、日期选择UITableView父类
//  使用方法：
//  1. 继承ESTableViewController
//  2. 创建ESGroup对象（一个ESGroup代表一个组）并且添加到self.groups中
//  3. 根据需要创建不同的ESItem子类
//  4. 创建ESCellFrame对象，设置item属性，也就是第三步创建的对象
//  5. 将ESCellFrame放入到ESGroup对象的items属性中
//  具体属性和方法见头文件

#import <UIKit/UIKit.h>
#import "ESItem.h"
#import "ESLabelItem.h"
#import "ESFieldItem.h"
#import "ESPickerItem.h"
#import "ESDateItem.h"
#import "ESGroup.h"
#import "ESCellFrame.h"

typedef enum {
    ESTableViewSectionMarginSmall,
    ESTableViewSectionMarginBig
} ESTableViewSectionMargin;

@interface ESTableViewController : UITableViewController

/**
 *  所有组数据模型
 */
@property (nonatomic, strong) NSMutableArray *groups;

/**
 *  sction之间的距离
 */
@property (nonatomic, assign) ESTableViewSectionMargin sctionMargin;

@end
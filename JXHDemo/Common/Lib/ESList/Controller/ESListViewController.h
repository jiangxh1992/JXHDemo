//
//  ESListViewController.h
//  sdfyy
//
//  Created by yh on 15/1/31.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  普通UITableView父类，一个标题，一个右侧指示箭头
//  改变预编译文件中cellmargin的大小可以调整cell的高度，cell的高度为：标题高度＋2*cellmargin
//  指示箭头的名字为listview_arrow,在工程中添加名为listview_arrow的图片资源设置箭头样式
//  使用方法：继承此类，将标题封装成ESListItem格式然后添加到items数组模型中即可；实现cell点击方法触发点击时间

#import <UIKit/UIKit.h>
#import "ESListItem.h"

@interface ESListViewController : UITableViewController

/**
 *  模型数组
 */
@property (nonatomic, strong) NSArray *items;

@end
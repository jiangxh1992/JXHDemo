//
//  NewRecordViewController.m
//  demo
//
//  Created by jiangxh on 15/10/8.
//  Copyright © 2015年 txbydev3. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NodeRecord;
@interface NewRecordViewController : UIViewController

/**
 *  结点数据模型
 */
@property (nonatomic, strong)NodeRecord *nodeRecord;

/**
 *  时间轴添加或者更新状态标记
 */
@property (nonatomic , copy)NSString *action;

@end

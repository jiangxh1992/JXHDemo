//
//  TimerShaftTableViewController.h
//  demo
//
//  Created by jiangxh on 15/9/26.
//  Copyright © 2015年 txbydev3. All rights reserved.
//
/**********************************
 *tableview实现时间轴效果:
 1.request函数取得时间轴数据
 2.从患者视图传入患者数据模型，在setHeaderAndFooter中设置患者头像和姓名
 3.
 **********************************/
#import <UIKit/UIKit.h>
// 枚举tag
enum {
    Tag_AlertView_NodeDetail,// 打开结点内容
    Tag_AlertView_DeleteNode // 删除结点
};
@class PatientDataItem;
@interface TimerShaftTableViewController : UITableViewController

/**
 *  数据模型
 */
@property (nonatomic)NSMutableArray *nodeRecords;

/**
 *  患者模型数据
 */
@property (nonatomic, strong) PatientDataItem *patientDataItem;

/**
 *  每次进入页面是否刷新数据
 */
@property (nonatomic)BOOL isUpdate;

@end
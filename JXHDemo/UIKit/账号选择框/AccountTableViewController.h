//
//  AccountTableViewController.h
//  JXHDemo
//
//  Created by Xinhou Jiang on 6/7/16.
//  Copyright © 2016 Jiangxh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AccountDelegate <NSObject>
/**
 * 选中cell的代理事件
 */
- (void) selectedCell:(NSInteger)index;

@end

@interface AccountTableViewController : UITableViewController

/**
 * 是否展开菜单
 */
@property (nonatomic)BOOL isOpen;

/**
 * 账号数据源
 */
@property (nonatomic) NSArray * accountSource;

/**
 * 定义代理
 */
@property (nonatomic, weak) id<AccountDelegate>delegate;

@end

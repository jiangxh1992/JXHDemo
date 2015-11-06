//
//  FoundationViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import "FoundationViewController.h"

#import "TestViewController.h"

@interface FoundationViewController ()

/**
 *  类名数组
 */
@property (nonatomic, strong)NSArray *classNames;

@end

@implementation FoundationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // cell的名称
    _classNames = @[@"TestViewController"];
    //设置模型数据
    NSMutableArray *mulItems = [[NSMutableArray alloc] init];
    for (NSString *name in _classNames) {
        ESListItem *item = [[ESListItem alloc] init];
        item.title = name;
        [mulItems addObject:item];
    }
    // 设置数据源
    self.items = mulItems;
}

@end
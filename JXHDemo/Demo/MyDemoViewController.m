//
//  MyDemoViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/5/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//
#import "MyDemoViewController.h"
#import "SplitTableViewController.h"
#import "MapViewController.h"
#import "TimerShaftTableViewController.h"
#import "CustomCalendarViewController.h"
#import "QRCodeViewController.h"
#import "PopMenuViewController.h"

@interface MyDemoViewController ()

/**
 *  类名数组
 */
@property (nonatomic, strong)NSArray *classNames;

@end

@implementation MyDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 扫描二维码按钮
    UIBarButtonItem *scanButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"scan"] style:UIBarButtonItemStylePlain target:self action:@selector(startScan)];
    self.navigationItem.rightBarButtonItem = scanButton;
    // 设置子视图类名表格数据
    [self setupClassNames];
}

/**
 *  设置子视图类名表格数据
 */
- (void)setupClassNames {
    // 子视图类名
    NSMutableArray *mulNames = [[NSMutableArray alloc] init];
    // cell的名称
    _classNames = @[@"SplitTableViewController", @"MapViewController", @"TimerShaftTableViewController", @"CustomCalendarViewController", @"PopMenuViewController"];
    for (NSString *name in _classNames) {
        ESListItem *item = [[ESListItem alloc] init];
        item.title = name;
        [mulNames addObject:item];
    }
    // 设置数据源
    self.items = mulNames;
}

/**
 *  cell点击跳转到控制器
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取出类名
    Class ClassName = NSClassFromString(_classNames[indexPath.row]);
    // 跳转到控制器
    [self.navigationController pushViewController:[[ClassName alloc] init] animated:YES];
}

/**
 *  打开二维码扫描器
 */
- (void)startScan {
    // 二维码视图控制器
    QRCodeViewController *qrcodeVC = [[QRCodeViewController alloc] init];
    qrcodeVC.QRCodeSuncessBlock = ^(QRCodeViewController *qrcvc, NSString *qrString) {
        XHAlert(@"扫描结果",qrString);
    };
    
    qrcodeVC.QRCodeFailBlock = ^(QRCodeViewController *qrcvc){
        [qrcvc dismissViewControllerAnimated:YES completion:nil];
    };
    qrcodeVC.QRCodeCancleBlock = ^(QRCodeViewController *qrcvc){
        [qrcvc dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:qrcodeVC animated:YES completion:nil];
}

@end
//
//  AccountSelectViewController.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 6/7/16.
//  Copyright © 2016 Jiangxh. All rights reserved.
//
#define inputW 250 // 选择框宽度
#import "AccountSelectViewController.h"
#import "AccountTableViewController.h"

@interface AccountSelectViewController ()<AccountDelegate>

/**
 * 账号数据
 */
@property (nonatomic) NSArray *dataSource;

/**
 * 当前账号选择框
 */
@property (nonatomic, copy) UIButton *curAccount;

/**
 *  账号下拉列表
 */
@property (nonatomic)AccountTableViewController *accountList;

@end

@implementation AccountSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.请求账号数据
    [self request];
    
    // 2.设置账号弹出菜单
    _accountList = [[AccountTableViewController alloc] init];
    // 数据传给下拉列表类，作为表格的数据源
    _accountList.accountSource = _dataSource;
    // 设置弹出菜单的代理为当前这个类
    _accountList.delegate = self;
    // 将下拉列表作为子页面添加到当前视图，同时添加子控制器
    [self addChildViewController:_accountList];
    [self.view addSubview:_accountList.view];
    
    // 3.当前账号选择框（这里用一个按钮实现）
    _curAccount = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 250, 40)];
    // 默认当前账号为已有账号的第一个
    [_curAccount setTitle:[_dataSource objectAtIndex:0] forState:UIControlStateNormal];
    // 字体颜色
    [_curAccount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 边框
    _curAccount.layer.borderWidth = 1.0;
    // 圆角
    _curAccount.layer.cornerRadius = 3.0;
    // 显示框背景色
    [_curAccount setBackgroundColor:[UIColor whiteColor]];
    // 根据显示框尺寸设置弹出菜单的位置和尺寸
    _accountList.view.frame = CGRectMake(_curAccount.frame.origin.x, _curAccount.frame.origin.y+_curAccount.frame.size.height, _curAccount.frame.size.width, 200);
    [self.view addSubview:_curAccount];
    // 下拉菜单弹出按钮
    UIButton *openBtn = [[UIButton alloc]initWithFrame:CGRectMake(inputW-30, 10, 20, 20)];
    [openBtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
    [openBtn addTarget:self action:@selector(openAccountList) forControlEvents:UIControlEventTouchUpInside];
    [_curAccount addSubview:openBtn];
}

/**
 * 请求数据
 */
- (void)request {
    _dataSource = [[NSArray alloc]initWithObjects:@"919575700@qq.com", @"123435@qq.com", @"476guh@outlook.com", @"gvb84t48@163.com", nil];
}

/**
 * 弹出账号选择列表
 */
- (void)openAccountList {
    _accountList.isOpen = !_accountList.isOpen;
    [_accountList.tableView reloadData];
}

/**
 * 选定cell获取选中账号的代理监听
 */
- (void)selectedCell:(NSInteger)index {
    // 更新当前选中账号
    [_curAccount setTitle:[_dataSource objectAtIndex:index] forState:UIControlStateNormal];
}

@end
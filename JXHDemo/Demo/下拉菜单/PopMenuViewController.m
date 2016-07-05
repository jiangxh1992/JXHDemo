//
//  PopMenuViewController.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 6/30/16.
//  Copyright © 2016 Jiangxh. All rights reserved.
//
#define inputW 230 // 输入框宽度
#define inputH 35  // 输入框高度

#import "PopMenuViewController.h"
#import "PopListTableViewController.h"
#import "Account.h"

@interface PopMenuViewController()<AccountDelegate>

/**
 * 账号数据
 */
@property (nonatomic) NSMutableArray *dataSource;

/**
 * 当前账号选择框
 */
@property (nonatomic, copy) UIButton *curAccount;

/**
 *  当前选中账号
 */
@property (nonatomic, strong) Account *curAcc;

/**
 * 当前账号头像
 */
@property (nonatomic, copy) UIImageView *icon;

/**
 *  账号下拉列表
 */
@property (nonatomic, strong) PopListTableViewController *accountList;

/**
 *  下拉列表的frame
 */
@property (nonatomic) CGRect listFrame;

@end

@implementation PopMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景
    self.view.backgroundColor = [UIColor whiteColor];
    // 加载数据
    [self request];
    // 设置下拉菜单
    [self setPopMenu];
}

/**
 * 设置下拉菜单
 */
- (void)setPopMenu {
    
    // 1.1帐号选择框
    _curAccount = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, inputW, inputH)];
    _curAccount.center = CGPointMake(self.view.center.x, 20);
    // 默认当前账号为已有账号的第一个
    Account *acc = _dataSource[0];
    [_curAccount setTitle:acc.account forState:UIControlStateNormal];
    // 字体
    [_curAccount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _curAccount.titleLabel.font = [UIFont systemFontOfSize:12.0];
    // 边框
    _curAccount.layer.borderWidth = 0.5;
    // 显示框背景色
    [_curAccount setBackgroundColor:[UIColor whiteColor]];
    [_curAccount addTarget:self action:@selector(openAccountList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_curAccount];
    // 1.2图标
    _icon = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, inputH-10, inputH-10)];
    _icon.layer.cornerRadius = (inputH-10)/2;
    [_icon setImage:[UIImage imageNamed:acc.avatar]];
    [_curAccount addSubview:_icon];
    // 1.3下拉菜单弹出按钮
    UIButton *openBtn = [[UIButton alloc]initWithFrame:CGRectMake(inputW - inputH, 0, inputH, inputH)];
    [openBtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
    [openBtn addTarget:self action:@selector(openAccountList) forControlEvents:UIControlEventTouchUpInside];
    [_curAccount addSubview:openBtn];
    
    // 2.设置账号弹出菜单(最后添加显示在顶层)
    _accountList = [[PopListTableViewController alloc] init];
    // 设置弹出菜单的代理为当前这个类
    _accountList.delegate = self;
    // 数据
    _accountList.accountSource = _dataSource;
    // 初始化frame
    [self updateListH];
    // 隐藏下拉菜单
    _accountList.view.frame = CGRectZero;
    // 将下拉列表作为子页面添加到当前视图，同时添加子控制器
    [self addChildViewController:_accountList];
    [self.view addSubview:_accountList.view];
}

/**
 *  监听代理更新下拉菜单
 */
- (void)updateListH {
    CGFloat listH;
    // 数据大于3个现实3个半的高度，否则显示完整高度
    if (_dataSource.count > 3) {
        listH = inputH * 3.5;
    }else{
        listH = inputH * _dataSource.count;
    }
    _listFrame = CGRectMake(_curAccount.frame.origin.x, _curAccount.frame.origin.y + _curAccount.frame.size.height, inputW, listH);
    _accountList.view.frame = _listFrame;
}

/**
 * 请求数据
 */
- (void)request {
        // 从工程plist文件读取账号模型数据(这个用到了MJExtension插件)
        _dataSource = [Account objectArrayWithFilename:@"account.plist"];
}

/**
 * 弹出关闭账号选择列表
 */
- (void)openAccountList {
    _accountList.isOpen = !_accountList.isOpen;
    if (_accountList.isOpen) {
        _accountList.view.frame = _listFrame;
    }
    else {
        _accountList.view.frame = CGRectZero;
    }
}

/**
 * 监听代理选定cell获取选中账号
 */
- (void)selectedCell:(NSInteger)index {
    // 更新当前选中账号
    Account *acc = _dataSource[index];
    [_icon setImage:[UIImage imageNamed:acc.avatar]];
    [_curAccount setTitle:acc.account forState:UIControlStateNormal];
    // 关闭菜单
    [self openAccountList];
}

@end
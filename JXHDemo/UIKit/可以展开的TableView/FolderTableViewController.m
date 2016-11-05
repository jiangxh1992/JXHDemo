//
//  FolderTableViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/23/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//
#define sectionHeaderH 30 //组头部的高度
#define ApplicationW [UIScreen mainScreen].bounds.size.width // 屏幕宽度
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0] // 通过RGB创建颜色

#import "FolderTableViewController.h"
#import "SectionHeaderView.h"
#import "AccountCell.h"

@interface FolderTableViewController ()<SectionHeaderDelegate>

/**
 *  记录section的展开状态
 */
@property (nonatomic, strong)NSMutableArray *isOpen;

/**
 *  记录section的标题数组
 */
@property (nonatomic, strong)NSArray *titles;

@end

@implementation FolderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 表格基本设置
    self.title = @"可展开的TableView";
    self.view.backgroundColor = RGBColor(240, 240, 240);
    // 清除底部多余cell
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    // 清除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 请求数据
    [self initValue];
}

/**
 *  请求数据
 */
- (void)initValue {
    // 标题数组假数据
    _titles = @[@"朋友", @"同学", @"家人", @"同事"];
    
    // 初始化所有section都是折叠状态
    _isOpen = [[NSMutableArray alloc] initWithCapacity:_titles.count];
    for (int i = 0; i<_titles.count; i++) {
        [_isOpen addObject:@NO];
    }
}

#pragma mark - 组设置
/**
 *  多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titles.count;
}
/**
 *  section header的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return sectionHeaderH;
}
/**
 *  section header的视图
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // section头部视图
    SectionHeaderView *sectionHeader = [[SectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, sectionHeaderH)];
    // 标题
    [sectionHeader setTitle:[_titles objectAtIndex:section] forState:UIControlStateNormal];
    // 为headerview打上tag
    [sectionHeader setTag:section];
    // 代理
    sectionHeader.delegate = self;
    
    return sectionHeader;
}
#pragma mark SectionHeader实现代理
/**
 *  实现代理，sectionheader 点击
 */
- (void)sectionDidClicked:(SectionHeaderView *)sender {
    
    // 取反状态
    BOOL reverse = ![_isOpen[sender.tag] boolValue];
    _isOpen[sender.tag] = [NSNumber numberWithBool:reverse];
    
    /***  这里刷新后section的header也会被刷新，导致指示箭头又恢复到旋转之前的状态，待解决  ***/
    // 刷新点击的分区（展开或折叠）
    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 组内行设置
/**
 *  每组多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_isOpen[section] boolValue]) {
        return 5; // 具体应该返回该分组好友的个数
    }else {
        return 0;
    }
}
/**
 *  cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"identifier";
    // 具体可以自制cell组件
    AccountCell *cell = [[AccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    // 头像，具体应该从好友数据中取
    [cell.avatar setImage:[UIImage imageNamed:@"male"]];
    // 昵称，具体应该从好友数据中取
    cell.name.text = @"夏明";
    //cell颜色
    //cell.backgroundColor = RGBColor(200, 200, 200);
    
    return cell;
}

@end

//
//  SplitTableViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/30/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//
#import "ESSearchBar.h"
#import "ESToolView.h"
#import "SplitTableViewController.h"
@interface SplitTableViewController () <ESToolViewDelegate, ESSearchBarDelegate>

/**
 *  内容占位视图
 */
@property (nonatomic, weak) UIView *contentView;

/**
 *  普通号控制器
 */
//@property (nonatomic, strong) WesternDrugViewController *westren;

/**
 *  特殊专家控制器
 */
//@property (nonatomic, strong) ChineseDrugViewController *chinese;

/**
 *  搜索框
 */
@property (nonatomic, weak) ESSearchBar *searchBar;

/**
 *  工具条
 */
@property (nonatomic, weak) ESToolView *toolView;

@end

@implementation SplitTableViewController

#pragma mark - getters
/**
 *  占位视图
 */
- (UIView *)contentView
{
    if (!_contentView)
    {
        // 1. 创建占位视图
        UIView *contentView = [[UIView alloc] init];
        _contentView = contentView;
        // 2. 设置frame
        contentView.frame = CGRectMake(0, CGRectGetMaxY(self.toolView.frame), self.view.width, ApplicationH - ESNavH - CGRectGetMaxY(self.toolView.frame));
        // 3. 背景颜色
        contentView.backgroundColor = [UIColor whiteColor];
        // 4. 添加到view中
        [self.view addSubview:contentView];
    }
    return _contentView;
}

///**
// *  西药控制器
// */
//- (WesternDrugViewController *)westren
//{
//    if (!_westren)
//    {
//        _westren = [[WesternDrugViewController alloc] init];
//        _westren.view.frame = self.contentView.bounds;
//        _westren.delegate = self;
//    }
//    return _westren;
//}
//
///**
// *  中药控制器
// */
//- (ChineseDrugViewController *)chinese
//{
//    if (!_chinese)
//    {
//        _chinese = [[ChineseDrugViewController alloc] init];
//        _chinese.view.frame = self.contentView.bounds;
//        _chinese.delegate = self;
//    }
//    return _chinese;
//}

#pragma mark - lifecycle
/**
 *  view加载完成
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1. 添加搜索框
    [self setupSearchBar];
    
    // 2. 添加工具条
    [self setupToolView];
    
    // 3. 默认选中西药
    [self toolView:nil didSelectedButtonAtIndex:0];
}

#pragma mark - private
/**
 *  添加搜索框
 */
- (void)setupSearchBar
{
    // 1. 创建搜索框
    ESSearchBar *searchBar = [ESSearchBar searchBar];
    self.searchBar = searchBar;
    CGFloat searchBarX = 5;
    CGFloat searchBarY = 5;
    CGFloat searchBarW = self.view.width - 2 * searchBarX;
    CGFloat searchBarH = 40;
    // 2. 设置frame
    searchBar.frame = CGRectMake(searchBarX, searchBarY, searchBarW, searchBarH);
    // 3. 设置提示文字
    searchBar.placeholder = @"请输入科室名称";
    // 3. 添加到view中
    [self.view addSubview:searchBar];
    // 4. 设置代理
    searchBar.delegate = self;
}

/**
 *  添加工具条
 */
- (void)setupToolView
{
    // 1. 创建工具条
    ESToolView *toolView = [ESToolView toolView];
    self.toolView = toolView;
    // 2. 设置frame
    CGFloat toolViewX = 0;
    CGFloat toolViewY = 50;
    CGFloat toolViewW = self.view.width;
    CGFloat toolViewH = 40;
    toolView.frame = CGRectMake(toolViewX, toolViewY, toolViewW, toolViewH);
    // 3. 根据按钮标题创建按钮
    toolView.buttonNames = @[@"普通号", @"特殊专家"];
    // 4. 添加到view中
    [self.view addSubview:toolView];
    // 5. 设置工具条代理
    toolView.delegate = self;
    // 6.设置工具条背景色
    toolView.backgroundColor = RGBColor(240, 240, 240);
}

#pragma mark - ESToolViewDelegate
/**
 *  选中ESToolView中的第几个按钮
 */
- (void)toolView:(ESToolView *)toolView didSelectedButtonAtIndex:(NSUInteger)index
{
    // 1. 退出键盘
    [self.view endEditing:YES];
    
    // 2. 移除所有子视图
    NSArray *subs = self.contentView.subviews;
    for (UIView *views in subs)
    {
        [views removeFromSuperview];
    }
    
    // 3. 根据工具条索引添加对应的view
    if (index == 0) // 普通号
    {
        //[self.contentView addSubview:self.westren.view];
    }
    else if (index == 1) // 特殊专家
    {
       // [self.contentView addSubview:self.chinese.view];
    }
}


#pragma mark - ESSearchBarDelegate
/**
 *  点击键盘上的搜索时调用
 */
- (void)searchBar:(ESSearchBar *)searchBar text:(NSString *)searchText
{
    // 跳转到列表控制器
    //[self drugMenuViewController:nil didClickWithItem:item];
}


@end

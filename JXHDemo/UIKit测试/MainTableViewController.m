//
//  MainTableViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/21/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//

#import "MainTableViewController.h"
#import "PinYin4Objc.h"

#import "LabelHeightViewController.h"
#import "OpenWebViewController.h"
#import "CheckBoxViewController.h"
#import "AlertViewController.h"
#import "FolderTableViewController.h"
#import "AffineViewController.h"
#import "AlertControllerViewController.h"
#import "PickerViewController.h"

@interface MainTableViewController ()<UISearchBarDelegate>

/**
 *  定义搜索框
 */
@property (nonatomic, strong)UISearchBar *searchBar;

/**
 *  子视图名称
 */
@property (nonatomic, strong)NSArray *classNames;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加搜索框到表格头部视图
    [self setHeaderSearchBar];
    // 设置数据
    [self setData];
}

/**
 *  添加搜索框到表格头部视图
 */
- (void)setHeaderSearchBar {
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, 40)];
    // 搜索框提示文字
    _searchBar.placeholder = @"ClassName";
    // 键盘return类型
    _searchBar.returnKeyType = UIReturnKeySearch;
    // 设置代理
    _searchBar.delegate = self;
    // 头部视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, 40)];
    [headerView addSubview:_searchBar];
    self.tableView.tableHeaderView = headerView;
}

/**
 * 设置数据
 */
- (void)setData {
    //视图名称
    _classNames = @[@"LabelHeightViewController", @"OpenWebViewController", @"CheckBoxViewController", @"AlertViewController", @"FolderTableViewController", @"AffineViewController", @"AlertControllerViewController", @"PickerViewController"];
    //设置模型数据
    NSMutableArray *mulItems = [[NSMutableArray alloc] init];
    for (NSString *name in _classNames) {
        // 定义封装组件并把classname封装进去
        ESListItem *item = [[ESListItem alloc] init];
        item.title = name;
        [mulItems addObject:item];
    }
    self.items = mulItems;
}

/**
 *  点击cell跳转
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取出类名
    Class ClassName = NSClassFromString(_classNames[indexPath.row]);
    // 跳转到控制器
    [self.navigationController pushViewController:[[ClassName alloc] init] animated:NO];
    }
#pragma mark - 搜索框代理监听
/**
 *   搜索框的内容发生变化
 *
 *  @param searchBar  searchBar
 *  @param searchText 搜索框当前的内容
 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"搜索框的内容发生变化");
    // 如果搜索文本为大写字母则转化为小写
    searchText = [searchText lowercaseString];
    // 没有输入内容
    if (!searchText.length) return;
    // 搜索更新前恢复全部原始数据
    [self setData];
    // 拼音输出格式
    HanyuPinyinOutputFormat *outputFormat = [[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeLowercase];
    // 可变数组存储筛选后的数据模型
    NSMutableArray *arrayM = [NSMutableArray array];
    // 遍历筛选
    for (ESListItem *item in self.items)
    {
        // 标题转化为拼音
        NSString *pinyin = [PinyinHelper toHanyuPinyinStringWithNSString:item.title withHanyuPinyinOutputFormat:outputFormat withNSString:@"#"];
        // 标题首字母
        NSMutableString *pinyinHeader = [NSMutableString string];
        NSArray *words = [pinyin componentsSeparatedByString:@"#"];
        for (NSString *word in words)
        {
            [pinyinHeader appendString:[word substringToIndex:0]];
        }
        // 去掉"#"
        pinyin = [pinyin stringByReplacingOccurrencesOfString:@"#" withString:@""];
        // 中文中包含搜索文字 // 拼音全称中包含搜索文字 // 拼音缩写中包含搜索文字
        if ([item.title rangeOfString:searchText].location != NSNotFound || [pinyin rangeOfString:searchText].location != NSNotFound || [pinyinHeader rangeOfString:searchText].location != NSNotFound)
        {
            [arrayM addObject:item];
        }
    }
    //设置过滤后的模型数组
    self.items = arrayM;
}
/**
 *  点击了键盘的搜索按钮
 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"点击了键盘的搜索按钮");
    // 退出键盘
    [self.view endEditing:YES];
}
/**
 *  输入内容结束
 */
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"输入内容结束");
    // 退出键盘
    [self.view endEditing:YES];
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"searchBarBookmarkButtonClicked");
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"searchBarCancelButtonClicked");
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"searchBarResultsListButtonClicked");
}
@end
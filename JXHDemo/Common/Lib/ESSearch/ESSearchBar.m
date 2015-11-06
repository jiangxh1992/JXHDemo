//
//  ESSearchBar.m
//  sdfyy
//
//  Created by yh on 15/1/26.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESSearchBar.h"

@interface ESSearchBar () <UITextFieldDelegate>

/**
 *  搜索框textField
 */
@property (nonatomic, weak) UITextField *searchBar;

@end

@implementation ESSearchBar

#pragma mark - getters
/**
 *  搜索框textField
 */
- (UITextField *)searchBar
{
    if (!_searchBar)
    {
        // 创建搜索框
        UITextField *searchBar = [[UITextField alloc] init];
        self.searchBar = searchBar;
        
        // 添加到view中
        [self addSubview:searchBar];
        
        // 设置背景
        searchBar.background = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
        // 设置font
        searchBar.font =[UIFont systemFontOfSize:14];
        // 设置内容垂直居中
        searchBar.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        // 设置右边永远显示清除按钮
        searchBar.clearButtonMode = UITextFieldViewModeAlways;
        // 设置键盘返回键为搜索
        searchBar.returnKeyType = UIReturnKeySearch;
        // 没有文字时搜索键不可点击
        searchBar.enablesReturnKeyAutomatically = YES;
        // 设置代理
        searchBar.delegate = self;
        
        // 设置左边显示一个放大镜
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageWithName:@"searchbar_textfield_search_icon"];
        leftView.width = leftView.image.size.width + 10;
        leftView.height = leftView.image.size.height;
        // 设置leftView的内容居中
        leftView.contentMode = UIViewContentModeCenter;
        searchBar.leftView = leftView;
        // 设置左边的view永远显示
        searchBar.leftViewMode = UITextFieldViewModeAlways;
        
        [searchBar addTarget:self action:@selector(change) forControlEvents:UIControlEventEditingChanged];
    }
    return _searchBar;
}

/**
 *  文本框文字变化
 */
- (void)change
{
    if ([self.delegate respondsToSelector:@selector(searchBar:textDidChange:)])
    {
        [self.delegate searchBar:self textDidChange:self.searchBar.text];
    }
}

#pragma mark - setters
/**
 *  设置提示文字
 */
- (void)setPlaceholder:(NSString *)placeholder
{
    // 成员变量赋值
    _placeholder = [placeholder copy];
    
    // 设置搜索框提示文字
    self.searchBar.placeholder = _placeholder;
}

#pragma mark - init
/**
 *  创建搜索框
 */
+ (instancetype)searchBar
{
    return [[self alloc] init];
}

#pragma mark - super
/**
 *  调整子控件位置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置搜索框frame
    self.searchBar.frame = self.bounds;
}

#pragma mark - UITextFieldDelegate
/**
 *  点击了return按钮(键盘最右下角的按钮)就会调用
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 1. 退出键盘
    [self endEditing:YES];
    
    // 2. 通知代理
    if ([self.delegate respondsToSelector:@selector(searchBar:text:)])
    {
        [self.delegate searchBar:self text:self.searchBar.text];
    }
    return YES;
}

@end
//
//  ESSearchBar.h
//  sdfyy
//
//  Created by yh on 15/1/26.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  自定义搜索框

#import <UIKit/UIKit.h>
@class ESSearchBar;

@protocol ESSearchBarDelegate <NSObject>

@optional
/**
 *  点击键盘上的搜索
 */
- (void)searchBar:(ESSearchBar *)searchBar text:(NSString *)searchText;

/**
 *  搜索框文字变化
 */
- (void)searchBar:(ESSearchBar *)searchBar textDidChange:(NSString *)searchText;

@end

@interface ESSearchBar : UIView

/**
 *  提示文字
 */
@property (nonatomic, copy) NSString *placeholder;

/**
 *  搜索框代理
 */
@property (nonatomic, assign) id <ESSearchBarDelegate> delegate;

/**
 *  创建搜索框
 */
+ (instancetype)searchBar;

@end
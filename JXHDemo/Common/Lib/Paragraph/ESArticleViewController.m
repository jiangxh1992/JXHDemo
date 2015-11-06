//
//  ESArticleViewController.m
//  smh
//
//  Created by yh on 15/3/25.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESArticleViewController.h"
#import "ArticleCellFrame.h"
#import "ArticleCell.h"
#import "Paragraph.h"

@interface ESArticleViewController ()

/**
 *  frame模型数据
 */
@property (nonatomic, strong) NSArray *cellFrames;

@end

@implementation ESArticleViewController

#pragma mark - setters
/**
 *  设置段落数组
 */
- (void)setParagraphs:(NSArray *)paragraphs
{
    _paragraphs = paragraphs;
    
    // 转ArticleCellFrame数组
    NSMutableArray *arrayM = [NSMutableArray array];
    for (Paragraph *paragraph in paragraphs)
    {
        ArticleCellFrame *cellFrame = [ArticleCellFrame cellFrameWithParagraph:paragraph];
        [arrayM addObject:cellFrame];
    }
    self.cellFrames = arrayM;
    
    // 刷新表格
    [self.tableView reloadData];
}

#pragma mark - lifecycle
/**
 *  view加载完成
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置表格属性
    [self setupTableView];
}

/**
 *  设置表格属性
 */
- (void)setupTableView
{
    // 去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDataSource
/**
 *  多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellFrames.count;
}

/**
 *  内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    static NSString *CellIdentifier = @"ArticleCell";
    ArticleCell *cell = [ArticleCell yhcellWithTableView:tableView classString:CellIdentifier];
    
    // 取出对应的模型
    cell.cellFrame = self.cellFrames[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
/**
 *  高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellFrames[indexPath.row] cellHeight];
}

@end
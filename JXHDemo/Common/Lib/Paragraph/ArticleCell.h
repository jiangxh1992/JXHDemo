//
//  ArticleCell.h
//  smh
//
//  Created by yh on 15/3/25.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  文章内容

#import <UIKit/UIKit.h>
@class ArticleCellFrame;

@interface ArticleCell : UITableViewCell

/**
 *  文章frame
 */
@property (nonatomic, strong) ArticleCellFrame *cellFrame;

@end
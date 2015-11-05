//
//  ESArticleViewController.h
//  smh
//
//  Created by yh on 15/3/25.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//  文章控制器

#import <UIKit/UIKit.h>
#import "Paragraph.h"

@interface ESArticleViewController : UITableViewController

/**
 *  段落数组
 */
@property (nonatomic, strong) NSArray *paragraphs;

@end
//
//  UITableViewCell+Extension.m
//  smh
//
//  Created by yh on 15/1/15.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)

/**
 *  创建一个可重用的cell
 *
 *  @param tableView  UITableView
 *  @param className  要创建的cell类名
 *  @param identifier 可重用标识符
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView classString:(NSString *)className identifier:(NSString *)identifier
{
    Class class = NSClassFromString(className);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[class alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    return cell;
}

/**
 *  创建一个可重用的cell(默认用类名当可重用标识符)
 *
 *  @param tableView  UITableView
 *  @param className  要创建的cell类名
 *  @param identifier 可重用标识符
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView classString:(NSString *)className
{
    return [self cellWithTableView:tableView classString:className identifier:className];
}

/**
 *  设置cell背景图片（cell背景图片相同时）
 */
- (void)setCommonBg
{
    // 1. 背景颜色
    self.backgroundColor = [UIColor clearColor];
    
    // 2. 普通状态下背景图片
    UIImageView *backgroundView = [[UIImageView alloc] init];
    backgroundView.image = [UIImage resizedImageWithName:@"common_card_background"];
    self.backgroundView = backgroundView;
    
    // 3. 点击时背景图片
    UIImageView *selectedBackgroundView = [[UIImageView alloc] init];
    selectedBackgroundView.image = [UIImage resizedImageWithName:@"common_card_background_highlighted"];
    self.selectedBackgroundView = selectedBackgroundView;
}

/**
 *  设置cell背景
 *
 *  @param indexPath  cell在表格中的位置
 *  @param count      cell所在section中的cell个数
 */
- (void)setBgAtIndexPath:(NSIndexPath *)indexPath countInSection:(NSUInteger)count
{
    // 1. 背景颜色
    self.backgroundColor = [UIColor clearColor];
    
    // 2. 算出文件名
    NSString *imageName = nil;
    if (count == 1) // 只有1个
    {
        imageName = @"common_card_background";
    }
    else if (indexPath.row == 0) // 顶部
    {
        imageName = @"common_card_top_background";
    }
    else if (indexPath.row == count - 1) // 底部
    {
        imageName = @"common_card_bottom_background";
    }
    else // 中间
    {
        imageName = @"common_card_middle_background";
    }
    
    // 3. 普通状态下背景图片
    UIImageView *backgroundView = [[UIImageView alloc] init];
    backgroundView.image = [UIImage resizedImageWithName:imageName];
    self.backgroundView = backgroundView;
    
    // 4. 点击时背景图片
    UIImageView *selectedBackgroundView = [[UIImageView alloc] init];
    selectedBackgroundView.image = [UIImage resizedImageWithName:[imageName stringByAppendingString:@"_highlighted"]];
    self.selectedBackgroundView = selectedBackgroundView;
}

@end
//
//  VisitTableTableViewController.m
//  demo
//
//  Created by txbydev3 on 15/9/10.
//  Copyright (c) 2015年 txbydev3. All rights reserved.
//
/****************************************************
 *这个tableviewcontroller专门用于回访记录界面
 ***************************************************/
#import "VisitTableTableViewController.h"
#import "VisitTableViewCell.h"
/***
 *宏定义
 */
//cell的高度
#define cellHeight 80.0
//cell左边的margin
#define leftMargin 30.0


@interface VisitTableTableViewController ()

@end

@implementation VisitTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //页面标题
    self.navigationItem.title = @"随访记录";
    
    //定制单元格样式
    [self setCell];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
/**
 *定制单元格样式
 */
- (void)setCell {
    //单元格高度
    self.tableView.rowHeight = cellHeight;
    //单元格背景色
    //self.tableView.backgroundColor = [UIColor greenColor];
    //分割线的颜色
    //self.tableView.separatorColor = [UIColor whiteColor];
    //分割线的样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //修改分隔线的长度
    //UIEdgeInsets edgeInset = self.tableView.separatorInset;
    //edgeInset = UIEdgeInsetsMake(edgeInset.top, 0, edgeInset.bottom, edgeInset.right);//逆时针：上左下右
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//table的分区个数, 这里不是group类型，暂时就一个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    return 1;
}
//返回表格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    return 10;//暂时手动设置为加载显示10行
}
//创建各单元显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"visitCellID";
    VisitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //禁止点击变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //如果缓冲池为空，重新创建
    if (!cell) {
        cell = [[VisitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //设置单元格中的显示内容
    //cell.textLabel.text = [_source objectAtIndex:indexPath.row];
    return cell;
}





// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

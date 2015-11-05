//
//  TimerShaftTableViewController.m
//  demo
//
//  Created by txbydev3 on 15/9/26.
//  Copyright © 2015年 txbydev3. All rights reserved.
//
/******************************************
 *这个tableview用来显示就诊时间轴页面
 ******************************************/
#import "TimerShaftTableViewController.h"
#import "TimerShaftCell.h"
#import "TimerButton.h"
/****************************************************************************************************************
 *根据日期节点之间距离计算cell高度的算法设计：
 *暂时简单设定：
 * cellHeight = (minCellHeight + 5 * (相差天数)) > maxCellHeight ? maxCellHeight : (minCellHeight + 5 * (相差天数))
 ****************************************************************************************************************/

@interface TimerShaftTableViewController ()<TimerButtonDelegate>

/*
 * 可变日期节点数组
 */
@property (nonatomic, strong) NSMutableArray *dateArray;
/**
 * 日期节点格式，年月日
 */
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
/**
 * 可变日期节点间距数组，保存用相邻日期节点的距离计算的cell的高度
 */
@property (nonatomic, strong) NSMutableArray *cellHeightArray;

@end


@implementation TimerShaftTableViewController
/**
 * 0.视图加载
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    //取消竖直滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    //设置基本单元格格式
    [self setCell];
    //初始化元素
    [self initElement];
    //初始化节点数据
    [self initDate];
    
    // 隐藏多余的cell空格
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    //设置表格的头部视图和尾部视图
    [self setHeaderAndFooter];
    
    //tableview的背景
    self.tableView.backgroundColor = [UIColor whiteColor];
    //背景图片
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, ApplicationW, ApplicationH)];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, ApplicationH)];
    [bgImageView setImage:[UIImage imageNamed:@"tree"]];
    [bgView addSubview:bgImageView];
    self.tableView.backgroundView = bgView;
}
/**
 * 自定义函数
 * 1.初始化元素
 */
- (void)initElement {
    _dateArray       = [[NSMutableArray alloc] init];
    _dateFormatter   = [[NSDateFormatter alloc] init];
    _cellHeightArray = [[NSMutableArray alloc] init];
}
/**
 * 自定义函数
 * 2.初始化节点数据
 */
- (void)initDate {
    //0.假数据时间节点数组
    NSArray *nodeArray = @[@"2015-09-26",@"2015-09-20",@"2015-08-20",@"2015-08-15",@"2015-06-20",@"2015-06-10",@"2015-03-20",@"2015-02-13",@"2014-05-01"];
    //1.设置时间格式
    [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //2.初始化日期节点数据
    for (int i = 0; i<nodeArray.count; i++) {
        NSData *date = [_dateFormatter dateFromString:[nodeArray objectAtIndex:i]];
        [_dateArray addObject:date];
    }
    //3.计算日期节点之间距离即cell的高度
    for (int d = 0; d<_dateArray.count; d++) {
        //相差日期天数
        int dateDistance = [self dateDistance:[_dateArray objectAtIndex:d] from:[_dateArray objectAtIndex:d+1]];
        //cell高度
        CGFloat cellHeight = [self cellHeightAlgrithm:dateDistance];
        //cell高度加入数组
        [_cellHeightArray addObject:@(cellHeight)];
        //
        //最后一个日期距离设置为minCellHeight
        if (d == (_dateArray.count-2)) {
            [_cellHeightArray addObject:@(maxCellHeight)];
            break;
        }
    }
    

    //打印测试
//    for (int d = 0;d < _cellHeightArray.count;d++) {
//        NSLog(@"cell高度：%@",[_cellHeightArray objectAtIndex:d]);
//    }
    for (int j = 0; j<_dateArray.count; j++) {
        NSString *s = [_dateFormatter stringFromDate:[_dateArray objectAtIndex:j]];
        NSLog(@"格式化后的日期:%@",s);
    }
}
/**
 * 自定义函数
 * 3.计算日期节点之间的相差天数
 */
- (int)dateDistance:(NSDate*)currentDate from:(NSDate*)preDate {
    //计算时间相差的秒数
    CGFloat t = [currentDate timeIntervalSinceDate:preDate];
    //天数
    return t/86400;
}
/**
 * 自定义函数
 * 4.计算cell高度算法
 */
- (CGFloat)cellHeightAlgrithm:(int)d {
    CGFloat cellH = ((minCellHeight + 5 * d) > maxCellHeight ? maxCellHeight : (minCellHeight + 5 * d));
    return cellH;
}
/**
 * 自定义函数
 * 5.设置基本单元格格式
 */
- (void)setCell {
    //单元格高度
    //self.tableView.rowHeight = cellHeight;
    /*去掉单元格样式，去背景，去边框*/
    //单元格背景色
    self.tableView.backgroundColor = [UIColor clearColor];
    //分割线的颜色
    //self.tableView.separatorColor = [UIColor whiteColor];
    //分割线的样式,无
    self.tableView.separatorStyle = UITableViewCellSelectionStyleDefault;
}

/**
 * 0.收到内存警告提示
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"时间轴tableview出现内存问题！");
}

#pragma mark - 表格cell数据设置
/**
 * 1.table的分区个数, 这里不是group类型，暂时就一个分区
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}
/**
 * 2.返回表格行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    NSLog(@"表格行数：%i",_cellHeightArray.count);
    return _cellHeightArray.count;
}

/**
 * 3.根据cell个数分别创建单元格
 */
- (TimerShaftCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *timerCellID = @"timerCellID";
    //cell的高度
    CGFloat cellH = [[_cellHeightArray objectAtIndex:indexPath.row] floatValue];
    //cell的行号
    NSInteger row = indexPath.row;
    NSLog(@"行号：%i",row);
    //放弃重用机制创建cell
    TimerShaftCell *cell = [[TimerShaftCell alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifer:timerCellID cellHeight:cellH row:row];
    //设置cell透明
    cell.backgroundColor = [UIColor clearColor];
    //点击禁止变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //复用cell可以修改cell 的内容但是无法修改cell的高度，因此放弃
//如果模版cell还没有创建则创建
//    if (!cell) {
//        cell = [[TimerShaftCell alloc] initWithStyle:UITableViewCellSelectionStyleDefault reuseIdentifer:timerCellID cellHeight:cellH];
//        //点击禁止变色
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    return cell;
}

/**
 *重载函数
 * 4.动态设置每一个cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimerShaftCell *cell =(TimerShaftCell *)([tableView dequeueReusableCellWithIdentifier:@"timerCellID"]);
    //cell的高度
    CGFloat cellH = [[_cellHeightArray objectAtIndex:indexPath.row] floatValue];
    NSLog(@"cell的高度：%f",cellH);
    return cellH;
}
/**
 * 5.响应日期组件按钮的代理事件
 */
- (void)btnDateDidClicked:(UIButton *)sender {
    NSLog(@"代理成功！");
}
#pragma mark 设置表格的头部视图和尾部视图
/**
 * 设置表格的头部视图和尾部视图
 */
- (void)setHeaderAndFooter {
    //自定义头部视图
    UIView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, minCellHeight)];
    //背景图片
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, minCellHeight)];
    [headerImageView setImage:[UIImage imageNamed:@"header"]];
    //[headerView addSubview:headerImageView];
    //患者头像
    UIImageView *patientImageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftMargin-25, 50, 50, 50)];
    [patientImageView setImage:[UIImage imageNamed:@"male"]];
    [patientImageView.layer setBorderColor:[UIColor greenColor].CGColor];
    [patientImageView.layer setBorderWidth:3];
    [patientImageView.layer setCornerRadius:25];
    [patientImageView.layer setMasksToBounds:YES];
    [headerView addSubview:patientImageView];
    //小鸟装饰图
    UIImageView *birdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(160, 60, 72, 87)];
    [birdImageView setImage:[UIImage imageNamed:@"bird"]];
    [headerView addSubview:birdImageView];
    
    [self.tableView setTableHeaderView:headerView];
    
    //自定义底部视图
    UIView *footerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, minCellHeight)];
    UIImageView *footerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftMargin-36, -30, 72, 87)];
    [footerImageView setImage:[UIImage imageNamed:@"bird"]];
    [footerView addSubview:footerImageView];
    [self.tableView setTableFooterView:footerView];
}
/**
 * 表格的header视图
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //自定义头部视图
    UIView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, minCellHeight)];
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, minCellHeight)];
    [headerImageView setImage:[UIImage imageNamed:@"header"]];
    [headerView addSubview:headerImageView];
    return headerView;
}
/**
 * 表格的footer视图
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    //自定义底部视图
    UIView *footerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, minCellHeight)];
    UIImageView *footerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, minCellHeight)];
    [footerImageView setImage:[UIImage imageNamed:@"header"]];
    [footerView addSubview:footerImageView];
    return footerView;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

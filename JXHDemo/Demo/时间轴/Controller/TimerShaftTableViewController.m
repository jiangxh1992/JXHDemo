//
//  TimerShaftTableViewController.h
//  demo
//
//  Created by jiangxh on 15/9/26.
//  Copyright © 2015年 txbydev3. All rights reserved.
//
/******************************************
 *这个tableview用来显示就诊时间轴页面
 ******************************************/
#import "TimerShaftTableViewController.h"
#import "TimerShaftCell.h"
#import "TimerButton.h"
#import "NewRecordViewController.h"
#import "NodeRecord.h"
//时间轴与屏幕左边的边距
#define LMargin ApplicationW/3
#define minCellHeight 80
#define maxCellHeight 160
// 横轴长度随天数差的增长速度
#define speed 1
/****************************************************************************************************************
 *根据日期节点之间距离计算cell高度的算法设计：
 *暂时简单设定：
 * cellHeight = (minCellHeight + speed * (相差天数)) > maxCellHeight ? maxCellHeight : (minCellHeight + speed * (相差天数))
 ****************************************************************************************************************/

@interface TimerShaftTableViewController ()<TimerButtonDelegate, UIAlertViewDelegate>

/**
 * 日期节点格式，年月日
 */
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

/**
 * 要删除或者修改的结点下标
 */
@property (nonatomic)NSInteger nodeIndex;

/**
 * 颜色库：用数组保存自定义的颜色，备用
 */
@property (nonatomic, strong) NSMutableArray *MyColor;

/**
 * 三角形名称库：用数组保存不同颜色的三角图片名称，备用
 */
@property (nonatomic, strong) NSMutableArray *Arrows;

@end

@implementation TimerShaftTableViewController

#pragma mark -lifecycle
/**
 *  判断是否刷新
 */
- (void) viewWillAppear:(BOOL)animated {
    if (_isUpdate) {
        [self request];
        _isUpdate = NO;
    }
}

/**
 * 视图加载
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // 导航栏设置
    [self setNav];
    // 设置颜色库
    [self initMyColor];
    // 设置基本单元格格式
    [self setCell];
    // 初始化元素
    [self initElement];
    // 设置表格的头部视图和尾部视图
    [self setHeaderAndFooter];
    // tableview的背景
    self.tableView.backgroundColor = [UIColor whiteColor];//SLColor(193, 224, 201);
    // 设置表格背景图片
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, ApplicationW, ApplicationH)];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, ApplicationH)];
    [bgImageView setImage:[UIImage imageNamed:@"tree"]];
    [bgView addSubview:bgImageView];
    self.tableView.backgroundView = bgView;
    
    // 请求数据
    [self request];
}

#pragma mark -private methods
/**
 * 请求数据
 */
- (void)request {
    // 取得的时间结点字典数据
    NSMutableArray *nodeRecords;
    
    /* 此处从本地取nodeRecords，可换成服务器取 */
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:SLNodeRecordsDomainPath]) {
        // 沙盒路径存在则从沙盒读取数据
        NSMutableArray *nodesDic = [[NSMutableArray alloc] initWithContentsOfFile:SLNodeRecordsDomainPath];
        // 字典数据转模型数据
        nodeRecords = [NodeRecord objectArrayWithKeyValuesArray:nodesDic];
    }else {
        // 如果是第一次结点数据沙盒为空，则取本地工程plist数据
        nodeRecords = [NodeRecord objectArrayWithFilename:@"nodeRecord.plist"];
    }
    
    /* 取得数据后的处理 */
    // 结点数据按照时间顺序降序排序
    [self nodesOrderDecend:nodeRecords];
    _nodeRecords = nodeRecords;
    // 设置结点颜色和箭头资源
    [self setColorAndArrows];
    // 初始化节点数据
    [self initDate];
    [self.tableView reloadData];
}

/**
 * 导航栏设置
 */
- (void)setNav {
    //页面标题
    self.title = @"时间轴";
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    //导航栏右侧发送按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNode)];
    //取消竖直滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
}

/**
 * 设置表格的头部视图和尾部视图
 */
- (void)setHeaderAndFooter {
    /* 1.自定义头部视图 */
    UIView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, maxCellHeight)];
    //患者头像
    CGFloat avatarSize = 60;// 头像尺寸
    UIImageView *patientImageView = [[UIImageView alloc] initWithFrame:CGRectMake(LMargin-avatarSize/2, maxCellHeight-50, avatarSize, avatarSize)];
    // 网络图片资源转化成UIImage显示
    //NSURL *imageUrl = [NSURL URLWithString:_patientDataItem.avatar];
    //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    [patientImageView setImage:[UIImage imageNamed:@"male"]];
    // 边框颜色
    [patientImageView.layer setBorderColor:RGBColor(206, 206, 206).CGColor];//96, 135, 8
    // 边框宽度
    [patientImageView.layer setBorderWidth:2];
    // 边框圆角
    [patientImageView.layer setCornerRadius:avatarSize/2];
    // 将layer下面的layer遮住
    [patientImageView.layer setMasksToBounds:YES];
    [headerView addSubview:patientImageView];
    
    //患者名字
    UIButton *patientName = [[UIButton alloc] initWithFrame:CGRectMake(patientImageView.frame.origin.x-60, patientImageView.centerY, 60, 20)];
    [patientName setTitle:@"李天一" forState:UIControlStateNormal];
    [patientName setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [headerView addSubview:patientName];
    //小鸟装饰图
    UIImageView *birdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(160, 60, 72, 87)];
    [birdImageView setImage:[UIImage imageNamed:@"bird"]];
    [headerView addSubview:birdImageView];
    
    [self.tableView setTableHeaderView:headerView];
    
    /* 2.自定义底部视图 */
    UIView *footerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ApplicationW, minCellHeight)];
    // 延长的竖轴线
    UIImageView *footerLine = [[UIImageView alloc] initWithFrame:CGRectMake(LMargin, 0, 2, 200)];
    [footerLine setImage:[UIImage imageNamed:@"time_vertical_line"]];
    [footerView addSubview:footerLine];
    // 镶边笑脸
    UIImageView *footerImage = [[UIImageView alloc] initWithFrame:CGRectMake(LMargin-25, footerLine.frame.size.height, 50, 50)];
    [footerImage setImage:[UIImage imageNamed:@"smiling"]];
    [footerImage.layer setBorderColor:RGBColor(206, 206, 206).CGColor];
    [footerImage.layer setBorderWidth:2];
    [footerImage.layer setCornerRadius:25];
    [footerImage.layer setMasksToBounds:YES];
    [footerView addSubview:footerImage];
    // 问候文字
    UILabel *footerLabel = [UILabel labelWithFont:XHFontSmall];
    [footerLabel setText:@"我是底部～"];
    footerLabel.textColor = [UIColor grayColor];
    // UILabel的宽和高
    CGFloat width = ApplicationW-LMargin-30;
    CGFloat height = [footerLabel.text sizeWithFont:XHFontSmall maxW:width].height;
    [footerLabel setFrame:CGRectMake(LMargin+30, footerImage.frame.origin.y, width, height)];
    [footerView addSubview:footerLabel];
    [self.tableView setTableFooterView:footerView];
}

/**
 * 时间结点数据按照时间倒序排序
 */
- (void) nodesOrderDecend:(NSMutableArray *)nodes {
    // 1.排序前的时间数组，作为排序对象
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    // 2.结点数组以日期为key依次存入字典
    NSMutableDictionary *nodesDictionary = [[NSMutableDictionary alloc] init];
    for (NodeRecord *node in nodes) {
        // 日期转换成日期字符串
        NSDate *date = [_dateFormatter dateFromString:node.date];
        [dateArray addObject:date];
        // 存入日期字典
        [nodesDictionary setObject:node forKey:node.date];
    }
    // 排序后的日期数组
    NSArray *orderedDateArray = [dateArray sortedArrayUsingComparator:^NSComparisonResult(NSDate *date1, NSDate *date2) {
        return [date2 compare:date1];
    }];
    // 将日期结点按顺序重新写入结点数组
    // 清空之前未排序的结点数组
    [nodes removeAllObjects];
    // 输入排序后的结点数据
    for (int i = 0; i<orderedDateArray.count; i++) {
        NSString *dateKey = [_dateFormatter stringFromDate:orderedDateArray[i]];
        [nodes addObject:[nodesDictionary objectForKey:dateKey]];
    }
}

/**
 * 设置自定义颜色库
 */
- (void)initMyColor {
    _MyColor = [[NSMutableArray alloc] init];
    _Arrows = [[NSMutableArray alloc] init];
    /** 设置自定义颜色库 **/
    //浅灰色SLColor(206,206,206)
    //橘红色SLColor(229,186,140)
    //淡绿色SLColor(212,228,162)
    //天蓝色SLColor(162,210,228)
    //海蓝色SLColor(162,178,228)
    //淡紫色SLColor(174,162,228)
    //洋红色SLColor(223,162,228)
    //粉红色SLColor(228,162,167)
    //[_MyColor addObject:SLColor(168,127,199)];
    [_MyColor addObject:RGBColor(229,186,140)];
    [_MyColor addObject:RGBColor(212,228,162)];
    [_MyColor addObject:RGBColor(162,210,228)];
    [_MyColor addObject:RGBColor(162,178,228)];
    [_MyColor addObject:RGBColor(174,162,228)];
    [_MyColor addObject:RGBColor(223,162,228)];
    [_MyColor addObject:RGBColor(228,162,167)];
    /** 设置相应三角按钮 **/
    //[_Arrows addObject:@"timer_arrow0"];
    [_Arrows addObject:@"timer_arrow1"];
    [_Arrows addObject:@"timer_arrow2"];
    [_Arrows addObject:@"timer_arrow3"];
    [_Arrows addObject:@"timer_arrow4"];
    [_Arrows addObject:@"timer_arrow5"];
    [_Arrows addObject:@"timer_arrow6"];
    [_Arrows addObject:@"timer_arrow7"];
}

/**
 *  设置结点颜色和箭头资源
 */
- (void)setColorAndArrows {
    for (int i = 0; i<_nodeRecords.count; i++) {
        NodeRecord *node = [_nodeRecords objectAtIndex:i];
        // 结点按钮颜色
        node.nodeColor = [_MyColor objectAtIndex:i%_MyColor.count];
        // 箭头图片资源
        node.arrowName = [_Arrows objectAtIndex:i%_Arrows.count];
    }
}

/**
 * 初始化元素
 */
- (void)initElement {
    _dateFormatter   = [[NSDateFormatter alloc] init];
    // 设置时间格式
    [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
}

/**
 * 初始化节点数据
 */
- (void)initDate {
    // 计算日期节点之间距离即cell的高度
    NSDate *currentDate,*preDate;
    for (int d = 0; d<_nodeRecords.count; d++) {
        //取出一个数据模型
        NodeRecord *dataModel = [_nodeRecords objectAtIndex:d];
        //最后一个日期距离设置为minCellHeight
        if (d == (_nodeRecords.count-1)) {
            dataModel.cellHeight = maxCellHeight;
            return;
        }
        //取出下一个数据模型
        NodeRecord *dateModelNext = [_nodeRecords objectAtIndex:d+1];
        currentDate = [_dateFormatter dateFromString:dataModel.date];
        preDate = [_dateFormatter dateFromString:dateModelNext.date];
        //相差日期天数
        int dateDistance = [self dateDistance:currentDate from:preDate];
        //cell高度加入数组
        dataModel.cellHeight = [self cellHeightAlgrithm:dateDistance];
    }
}

/**
 * 计算日期节点之间的相差天数
 */
- (int)dateDistance:(NSDate*)currentDate from:(NSDate*)preDate {
    //计算时间相差的秒数
    CGFloat t = [currentDate timeIntervalSinceDate:preDate];
    //天数
    return t/86400;
}

/**
 * 计算cell高度算法
 */
- (CGFloat)cellHeightAlgrithm:(int)d {
    CGFloat cellH = ((minCellHeight + speed * d) > maxCellHeight ? maxCellHeight : (minCellHeight + speed * d));
    return cellH;
}

/**
 * 设置基本单元格格式
 */
- (void)setCell {
    /*去掉单元格样式，去背景，去边框*/
    //单元格背景色
    self.tableView.backgroundColor = [UIColor clearColor];
    //分割线的样式,无
    self.tableView.separatorStyle = UITableViewCellSelectionStyleDefault;
    // 隐藏多余的cell空格
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}

/**
 * 添加新建节点界面
 */
- (void)addNode {
    // 创建编辑界面
    NewRecordViewController *newRecordVC = [[NewRecordViewController alloc] init];
    // 编辑状态为添加
    newRecordVC.action = @"create";
    [self.navigationController pushViewController:newRecordVC animated:YES];
}

#pragma mark - tableview datasource
/**
 * 1.table的分区个数, 这里不是group类型，暂时就一个分区
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/**
 * 2.返回表格行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _nodeRecords.count;
}

/**
 * 3.根据cell个数分别创建单元格
 */
- (TimerShaftCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取出一个数据模型
    NodeRecord *node = [_nodeRecords objectAtIndex:indexPath.row];
    // cell的行号
    node.row = indexPath.row;
    
    static NSString *timerCellID = @"timerCellID";
    // 放弃重用机制创建cell
    TimerShaftCell *cell = [[TimerShaftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifer:timerCellID nodeRecord:node];
    // 设置cell透明
    cell.backgroundColor = [UIColor clearColor];
    // 设置cell的自定义代理
    cell.delegate = self;
    // 日期
    [cell.timerBtn.btnDate setTitle:node.date  forState:UIControlStateNormal];
    // 就诊类型
    [cell.timerBtn.btnContent setTitle:node.type forState:UIControlStateNormal];
    // 给就诊类型内容按钮打上tag
    [cell.timerBtn.btnContent setTag:indexPath.row];
    // 点击禁止变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 * 重载函数
 * 4.动态设置每一个cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //cell的高度
    NodeRecord *node = [_nodeRecords objectAtIndex:indexPath.row];
    CGFloat cellH = node.cellHeight;
    return cellH;
}

#pragma mark timerbtn delegate
/**
 * .响应日期内容按钮的代理事件
 */
- (void)btnContentDidClicked:(UIButton *)sender {
    // 按钮文字作为弹出框标题
    NSString *btnText = sender.titleLabel.text;
    // 取模型中的数据
    NodeRecord *dataModel = [_nodeRecords objectAtIndex:sender.tag];
    // 定义一个扩展了的UIAlertView
    // 结点详情
    NSString *treatDetail = [NSString stringWithFormat:@"治疗过程：%@\n过程评估：%@",dataModel.treat_progress,dataModel.treat_estimate];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:btnText message:treatDetail delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"编辑", nil];
    alertView.tag = Tag_AlertView_NodeDetail;
    //弹出提示框
    [alertView show];
}

/**
 * .响应删除结点按钮的代理事件
 */
- (void)btnNodeDidClicked:(UIButton *)sender {
    //更新删除结点下标
    _nodeIndex = sender.tag;
    //提示询问用户是否确定删除
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@" " message:@"确定删除就诊记录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = Tag_AlertView_DeleteNode;
    [alertView show];
}

#pragma mark AlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // 1.打开结点内容alertview
    if (alertView.tag == Tag_AlertView_NodeDetail) {
        if (buttonIndex == 1) {
            // 创建编辑界面
            NewRecordViewController *newRecordVC = [[NewRecordViewController alloc] init];
            // 传入患者id
            // ... ...
            // 传入已有数据
            newRecordVC.nodeRecord = [_nodeRecords objectAtIndex:_nodeIndex];
            // 传入动作
            newRecordVC.action = @"update";
            [self.navigationController pushViewController:newRecordVC animated:YES];
        }
    }else if (alertView.tag == Tag_AlertView_DeleteNode) {
        // 2.删除结点alertview
        //如果选择确定则删除cell
        if (buttonIndex == 1) {
            // 1.请求服务器删除结点
            // ... ...
            
            /* 服务器删除成功后 */
            // 删除结点数据并刷新显示
            [_nodeRecords removeObjectAtIndex:_nodeIndex];
            [self.tableView reloadData];
            
            // 删除沙盒结点数据
            // 读取字典数据
            NSMutableArray *nodesDic = [[NSMutableArray alloc] initWithContentsOfFile:SLNodeRecordsDomainPath];
            // 转换成模型数据
            NSMutableArray *nodes = [NodeRecord objectArrayWithKeyValuesArray:nodesDic];
            // 排序
            [self nodesOrderDecend:nodes];
            // 移除
            [nodes removeObjectAtIndex:_nodeIndex];
            // 转回字典
            NSMutableArray *newNodes = [NSMutableArray keyValuesArrayWithObjectArray:nodes];
            [newNodes writeToFile:SLNodeRecordsDomainPath atomically:YES];
        }
    }
}

@end
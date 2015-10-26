//
//  TestViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/23/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<UIActionSheetDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(230, 230, 230);
    
    // 1.测试sizeToFit
    //[self sizeToFit];
    
    /**
     * 对于弹出警示框组件(UIAlertView)和弹出操作表(UIActionSheet)API上面说已经被苹果弃用了，整合成了UIAlertController
     * 对UIAlertController设置需要的类型:UIAlertControllerStyleAlert和UIAlertControllerStyleActionSheet来的到提示框和操作表组件
     */
    // 2.UIAlertView,UIActionSheet,UIAlertController组件测试
    //UIAlertView组件测试
    [self alertView];
    //UIActionSheet组件测试
    [self actionSheet];
    //UIAlertController组件测试
    [self alertController];
}
/**
 *  1.测试sizeToFit
 */
- (void)sizeToFit {
    /**
     *  有时候UIView的尺寸不好直接设置，需要根据内容来改变UIView的尺寸，这就需要使用sizeToFit方法。
     *  以UILabel为例，使用sizeToFit方法后，可以根据UILabel中字符串大小自动调整UILabel的大小
     *  UIButton使用sizeToFit方法，会根据button标题的大小自动调整UIButton的大小
     */
    //零尺寸UILabel
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    //设置中心
    label.center = CGPointMake(0, self.view.center.y);
    //label背景色，便于看其尺寸
    [label setBackgroundColor:[UIColor grayColor]];
    //label字体颜色
    label.textColor = [UIColor whiteColor];
    //label文字内容
    label.text = @"UILabel会根据我的长度变化大小";
    //sizeToFit
    [label sizeToFit];
    //显示label
    [self.view addSubview:label];
}
/**
 *  2.1 UIAlertView组件测试
 */
- (void)alertView {
}
/**
 *  2.2 UIActionSheet组件测试
 */
- (void)actionSheet {
    /**
     ActionSheet操作表，用来罗列用户的操作
     .操作表有四种系统类型(属性：actionSheetStyle)：
     UIActionSheetStyleAutomatic        = -1,// 采用工具栏的样式，否则使用默认default样式
     UIActionSheetStyleDefault          = UIBarStyleDefault,
     UIActionSheetStyleBlackTranslucent = UIBarStyleBlackTranslucent,
     UIActionSheetStyleBlackOpaque      = UIBarStyleBlackOpaque,
     
     .ActionSheet的事件代理(UIActionSheetDelegate):
     
     */
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"操作表" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:@"按钮1", @"按钮2", @"按钮3", nil];
    //操作表的类型
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    // 按顺序追一个按钮
    [actionSheet addButtonWithTitle:@"追加的按钮"];
    // 取得按钮的个数
    NSInteger btnNum = [actionSheet numberOfButtons];
    NSLog(@"操作表按钮的个数:%li",(long)btnNum);
    //设置代理
    actionSheet.delegate = self;
    // 弹出操作表
    [actionSheet showInView:self.view];
}
/**
 *  2.3 UIAlertController组件测试
 */
- (void)alertController {
}

@end
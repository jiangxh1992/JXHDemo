//
//  AlertControllerViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/26/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//

#import "AlertControllerViewController.h"

@interface AlertControllerViewController ()

@end

@implementation AlertControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(230, 230, 230);
    
    //1.UIActionSheet组件测试
    [self actionSheet];
    
    //2.UIAlertView组件测试
    //[self alertView];
    
    //3.UIAlertController组件测试
    //[self alertController];
}
/**
 ActionSheet操作表，用来罗列用户的操作
 
 1.操作表有四种系统样式类型(属性：actionSheetStyle)：
 UIActionSheetStyleAutomatic        = -1,// 这是这个属性的默认设置，采用工具栏的样式，即与工具条或者标签条在一起自动设置操作表样式，否则没有工具栏时使用默认default样式
 UIActionSheetStyleDefault          = UIBarStyleDefault,//常用的以半透明的灰色为基调的样式
 UIActionSheetStyleBlackTranslucent = UIBarStyleBlackTranslucent,//以半透明的黑色为基调的样式
 UIActionSheetStyleBlackOpaque      = UIBarStyleBlackOpaque,//以不透明的黑色为基调的样式
 
 2.ActionSheet的事件代理(UIActionSheetDelegate):
 - (void)willPresentActionSheet:(UIActionSheet *)actionSheet //操作表显示前调用
 - (void)didPresentActionSheet:(UIActionSheet *)actionSheet  //操作表显示后调用
 - (void)actionSheetCancel:(UIActionSheet *)actionSheet //操作表被意外强制关闭时调用，不是触摸取消按钮时调用
 - (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex //点击操作表的按钮时调用
 - (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex //操作表关闭前调用
 - (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex //操作表关闭后调用以及程序进入睡眠状态时调用
 
 3.ActionSheet的显示：
 在一般的view中操作表的显示是调用showInView:方法，但是在工具条或者标签条中必须调用专门的显示方法：
 showInView:view           //一般view中弹出显示
 showFromToolBar:toolBar   //工具条中弹出显示
 showFromTabBar:tabBar     //标签条中弹出显示
 
 4.ActionSheet的获取属性函数及其属性
 addButtonWithTitle:(NSString *)title;    //按顺序追一个带标题的按钮
 buttonTitleAtIndex:(NSInteger)buttonIndex;//取得第buttonIndex个按钮的标题
 numberOfButtons;//操作表按钮的个数
 cancelButtonIndex;//取消按钮的下标,没有把追加的按钮算进去
 destructiveButtonIndex;//确定按钮的下标
 firstOtherButtonIndex;//第一个其他按钮的下标
 visible;//操作表可见属性
 */
/**
 *  1.UIActionSheet组件测试
 */
- (void)actionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"操作表" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:@"按钮1", @"按钮2", @"按钮3", nil];
    //操作表的类型
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    // 按顺序追一个带标题的按钮
    [actionSheet addButtonWithTitle:@"追加的按钮"];
    // 取得按钮的个数
    NSInteger btnNum = [actionSheet numberOfButtons];
    NSLog(@"操作表按钮的个数:%li",(long)btnNum);
    // 取得第几个按钮的标题
    NSString *btnTitle = [actionSheet buttonTitleAtIndex:0];
    NSLog(@"第一个按钮为:%@",btnTitle);
    //取消按钮的下标
    NSLog(@"取消按钮的下标:%li",[actionSheet cancelButtonIndex]);
    //确定按钮的下标
    NSLog(@"确定按钮的下标:%li",[actionSheet destructiveButtonIndex]);
    //第一个其他按钮的下标
    NSLog(@"第一个其他按钮的下标:%li",[actionSheet firstOtherButtonIndex]);
    //设置代理
    actionSheet.delegate = self;
    // 弹出操作表
    [actionSheet showInView:self.view];
}
#pragma mark - actionSheet状态监视代理
//操作表显示前调用
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    NSLog(@"操作表显示前");
}
//操作表显示后调用
- (void)didPresentActionSheet:(UIActionSheet *)actionSheet {
    NSLog(@"操作表显示后");
}
//操作表被意外强制关闭时调用，不是触摸取消按钮时调用
- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
    NSLog(@"操作表被意外强制关闭");
}
//点击操作表的按钮时调用
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *btnTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    NSLog(@"点击了按钮:%@",btnTitle);
}
//操作表关闭前调用
- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"操作表关闭前");
}
//操作表关闭后调用以及程序进入睡眠状态时调用
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"操作表关闭或者程序进入睡眠状态");
}

/**
 UIAlertView用来弹出与用户交互的信息框以及输入框
 1.提示框的四中样式类型(alertViewStyle):
 UIAlertViewStyleDefault               //默认只有提示信息和按钮的提示框
 UIAlertViewStyleSecureTextInput       //带一个密码验证输入框的提示框
 UIAlertViewStylePlainTextInput        //带一个一般输入框的提示框
 UIAlertViewStyleLoginAndPasswordInput //带一个帐号和密码登录输入框的提示框
 
 2.AlertView的事件代理，基本和操作表一样(UIActionSheetDelegate):
 - (void)willPresentAlertView:(UIAlertView *)alertView                                        //显示前调用
 - (void)didPresentAlertView:(UIAlertView *)alertView                                         //显示后调用
 - (void)alertViewCancel:(UIAlertView *)alertView                                             //提示框被意外强制关闭时调用，不是触摸取消按钮时调用
 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex       //点击了第buttonIndex个按钮时调用
 - (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex //提示框关闭前调用
 - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex  //提示框关闭后调用以及程序进入睡眠状态时调用
 - (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView                       //输入框样式中输入框编辑后以及输入内容过程中调用，返回值为NO时禁用其他按钮点击，返回YES允许其他按钮点击
 
 3.AlertView的显示就一个函数:
 [alertView show];
 设置点击第buttonIndex个按钮后关闭提示框
 dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;
 
 4.AlertView的获取属性函数及其属性,跟操作表类似
 addButtonWithTitle:(NSString *)title;    //按顺序追一个带标题的按钮
 buttonTitleAtIndex:(NSInteger)buttonIndex;//取得第buttonIndex个按钮的标题
 numberOfButtons;//操作表按钮的个数
 cancelButtonIndex;//取消按钮的下标,没有把追加的按钮算进去
 destructiveButtonIndex;//确定按钮的下标
 firstOtherButtonIndex;//第一个其他按钮的下标
 visible;//操作表可见属性
 textFieldAtIndex:(NSInteger)textFieldIndex;//取得指定下标的输入框UITextField
 */
/**
 *  2.UIAlertView组件测试
 */
- (void)alertView {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示框" message:@"提示信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //提示框类型
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    //设置代理
    alertView.delegate = self;
    //显示提示框
    [alertView show];
}
#pragma mark - alertView状态监视代理
//显示前调用
- (void)willPresentAlertView:(UIAlertView *)alertView {
    NSLog(@"提示框显示前");
}
//显示后调用
- (void)didPresentAlertView:(UIAlertView *)alertView {
    NSLog(@"提示框显示后");
}
//提示框被意外强制关闭时调用，不是触摸取消按钮时调用
- (void)alertViewCancel:(UIAlertView *)alertView {
    NSLog(@"提示框被意外强制关闭，不是触摸取消按钮");
}
//点击了第buttonIndex个按钮时调用
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    NSLog(@"点击了按钮:%@",btnTitle);
    //如果点击了确定，取出输入框的内容
    if (buttonIndex == 1) {
        NSLog(@"用户名为:%@",[alertView textFieldAtIndex:0].text);
        NSLog(@"密码为:%@",[alertView textFieldAtIndex:1].text);
    }
}
//提示框关闭前调用
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"提示框关闭前");
}
//提示框关闭后调用以及程序进入睡眠状态时调用
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"提示框关闭后或者程序进入睡眠状态");
}
//输入框样式中输入框开始编辑后以及输入内容过程中调用，返回值为NO时禁用其他按钮点击，返回YES允许其他按钮点击
- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{
    NSLog(@"开始编辑或者输入框内容变化");
    //这里设置只有两个输入框的内容都不为空时启用其他按钮进行进一步操作
    if ([[alertView textFieldAtIndex:0].text isEqualToString:@""] || [[alertView textFieldAtIndex:1].text isEqualToString:@""]) {
        return NO;
    }else {
        return YES;
    }
    
}
/**
 *  3.UIAlertController组件测试
 */
- (void)alertController {
    /**
     整合的UIAlertController:
     对于弹出警示框组件(UIAlertView)和弹出操作表(UIActionSheet)API上面说已经被苹果弃用了，整合成了UIAlertController
     对UIAlertController设置需要的类型:UIAlertControllerStyleAlert和UIAlertControllerStyleActionSheet来的到提示框和操作表组件
     但目前好像并不好用，可以更自由的DIY只能说
     */
}

@end
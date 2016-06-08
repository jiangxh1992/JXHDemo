//
//  InputAjustViewController.m
//  JXHDemo
//
//  Created by Xinhou Jiang on 6/8/16.
//  Copyright © 2016 Jiangxh. All rights reserved.
//
#define inputW 200     // 输入框宽高
#define inputH 40
#define minDistance 10 // 键盘与输入框调整的最小间距
#define navH 64        // 如果当前页面有导航栏的话要加入导航栏高度的考虑

#import "InputAjustViewController.h"

@interface InputAjustViewController()<UITextFieldDelegate>

/**
 * 正在编辑的输入框
 */
@property (nonatomic, strong)UITextField *inputFeild;

/**
 * 输入框防遮挡调整的offset
 */
@property (nonatomic)CGFloat offset;

@end

@implementation InputAjustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置输入框
    [self setInputFeild];
    
    // 注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 * 设置输入框
 */
- (void)setInputFeild {
    // 2个输入框
    UITextField *input = [[UITextField alloc] initWithFrame:CGRectMake(ApplicationW/2 - inputW/2, ApplicationH/2, inputW, inputH)];
    //设置当前控制器代理
    input.delegate = self;
    //边框类型
    input.borderStyle = UITextBorderStyleRoundedRect;
    //背景色
    input.backgroundColor = [UIColor whiteColor];
    //placeholder
    input.placeholder = @"Please input...";
    [self.view addSubview:input];
    
    UITextField *input2 = [[UITextField alloc] initWithFrame:CGRectMake(ApplicationW/2 - inputW/2, ApplicationH/3*2, inputW, inputH)];
    //设置当前控制器代理
    input2.delegate = self;
    //边框类型
    input2.borderStyle = UITextBorderStyleRoundedRect;
    //背景色
    input2.backgroundColor = [UIColor whiteColor];
    //placeholder
    input2.placeholder = @"Please input...";
    [self.view addSubview:input2];
}

/**
 * 键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification*)notificationShow {
    // 获取键盘信息数据
    NSDictionary *keyboardInfo = [notificationShow userInfo];
    // 获取键盘高度
    CGFloat keyboardH = [[keyboardInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    // 计算遮挡的offset
    _offset = _inputFeild.frame.origin.y + _inputFeild.frame.size.height + keyboardH + minDistance + navH - ApplicationH;
    if(_offset > 0) {
        // 将当前view往上移动offset距离
        CGRect frame = self.view.frame;
        self.view.frame = CGRectMake(0, frame.origin.y-_offset, frame.size.width, frame.size.height);
    }
}

/**
 * 键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification*)notificationHide {
    // 将当前view移回
    if(_offset > 0) {
        CGRect frame = self.view.frame;
        self.view.frame = CGRectMake(0, frame.origin.y+_offset, frame.size.width, frame.size.height);
    }
}

/**
 * 调用当前view的触摸事件撤销键盘
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //[self.view endEditing:YES];//取消第一响应者
    [_inputFeild resignFirstResponder];//直接取消输入框的第一响应
}

/**
 * 输入框开始编辑代理事件
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // 将要编辑的输入框设置为当前目标调整输入框
    _inputFeild = textField;
    return YES;
}

@end
//
//  OpenWebViewController.m
//  Demo
//
//  Created by 919575700@qq.com on 10/15/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//
#define btnSize 30 //按钮尺寸
#import "OpenWebViewController.h"

@interface OpenWebViewController ()<UIWebViewDelegate, UITextInputTraits>

@end

@implementation OpenWebViewController
/**
 *  视图加载
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    //0.背景色，标题
    self.view.backgroundColor = RGBColor(230, 230, 230);
    self.title = @"WEB浏览器";
    /***********************
     * UITextFeild的用法
     ***********************/
    //1.输入框
    _inputFeild = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, ApplicationW - btnSize - 10, btnSize)];
    //边框
    //_inputFeild.layer.borderWidth = 1;
    //_inputFeild.layer.borderColor = [UIColor orangeColor].CGColor;
    //边框类型
    _inputFeild.borderStyle = UITextBorderStyleRoundedRect;
    //背景色
    _inputFeild.backgroundColor = [UIColor whiteColor];
    //placeholder
    _inputFeild.placeholder = @"Please input address...";
    //文字颜色
    _inputFeild.textColor = [UIColor blueColor];
    //文字对齐格式
    //_inputFeild.textAlignment = UITextAlignmentLeft;
    //文字大小和字体
    _inputFeild.font = [UIFont fontWithName:@"Times New Roman" size:20];
    //文字自适应
    _inputFeild.adjustsFontSizeToFitWidth = YES;
    //请文字清除按钮
    _inputFeild.clearsOnBeginEditing =YES;
    
    //左边view
    //_inputFeild.leftView = UIImageView;
    //_inputFeild.leftViewMode = UITextFieldViewModeAlways;
    //右边view同理
    
    //代理
    //_inputFeild.delegate = self;
    //显示
    [self.view addSubview:_inputFeild];
    // 2.go按钮
    _goButton = [[UIButton alloc] initWithFrame:CGRectMake(_inputFeild.frame.origin.x + _inputFeild.frame.size.width+2, _inputFeild.frame.origin.y, btnSize, btnSize)];
    //按钮文字
    [_goButton setTitle:@"Go" forState:UIControlStateNormal];
    //按钮圆角
    _goButton.layer.cornerRadius = 5;
    //按钮背景
    _goButton.backgroundColor = [UIColor grayColor];
    //注册事件
    [_goButton addTarget:self action:@selector(goButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    //显示
    [self.view addSubview:_goButton];
    // 3.webview
    _webView = [[UIWebView alloc] init];
    //frame
    [_webView setFrame:CGRectMake(5, btnSize + 10, ApplicationW-10, ApplicationH - btnSize - 10)];
    //边框
    _webView.layer.borderWidth = 1;
    _webView.layer.borderColor = (__bridge CGColorRef)([UIColor orangeColor]);
    //自适应
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
    _webView.scalesPageToFit = YES;
    //设置webview的代理
    _webView.delegate = self;
    //添加到页面
    [self.view addSubview:_webView];
}
/**
 *  点击了go按钮的触发函数
 */
- (void)goButtonPressed {
    //取输入框的网址
    NSString *urlStr = _inputFeild.text;
    NSLog(@"输入的网址：%@",urlStr);
    //打开网址页面
    [self loadWebViewWithString:urlStr];
}
/**
 *  加载网址页面
 */
- (void)loadWebViewWithString:(NSString*)urlStr {
    // 网址字符串转URL
    NSURL *url = [NSURL URLWithString:urlStr];
    // url请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 加载url请求
    [_webView loadRequest:request];
}
#pragma mark webview委托方法
/**
 *  开始加载
 */
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"开始加载...");
}
/**
 *  加载完成
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"加载完成...");
}
/**
 *  加载出错
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"加载出错！");
}
#pragma mark 输入框键盘属性委托
/**
 *  键盘类型
 */
- (UIKeyboardType)keyboardType {
    // URL输入用键盘
    return UIKeyboardTypeURL;
}
/**
 *  return键的变更
 */
- (UIReturnKeyType)returnKeyType {
    // Go
    return UIReturnKeyGo;
}
@end
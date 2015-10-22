//
//  OpenWebViewController.h
//  Demo
//
//  Created by 919575700@qq.com on 10/15/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenWebViewController : UIViewController
/**
 *  网址输入框
 */
@property (nonatomic, strong)UITextField *inputFeild;
/**
 *  webview
 */
@property (nonatomic, strong)UIWebView *webView;
/**
 *  go按钮
 */
@property (nonatomic, strong)UIButton *goButton;
/**
 *  点击了go按钮的触发函数
 */
- (void)goButtonPressed;
/**
 *  加载网址页面
 */
- (void)loadWebViewWithString: (NSString *)urlStr;

@end

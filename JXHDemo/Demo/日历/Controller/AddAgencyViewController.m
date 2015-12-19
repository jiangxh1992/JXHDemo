//
//  AddAgencyViewController.m
//  slyy_department_edition
//
//  Created by jiangxh on 15/9/18.
//  Copyright (c) 2015年 eeesysmini2. All rights reserved.
//

#import "AddAgencyViewController.h"

@interface AddAgencyViewController ()

@end

@implementation AddAgencyViewController
/*
 *  视图加载
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // 页面标题
    self.navigationItem.title = _dateStr;
    // 保存按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAgency)];
    // 1.数据读取
    [self getData];
    // 2.输入框设置
    [self setInputView];
}

/**
 *  输入框设置
 */
- (void)setInputView {
    // 将输入框的尺寸设置为屏幕大小
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    // 输入框的字体颜色
    self.textView.textColor = [UIColor orangeColor];
    // 字体大小
    self.textView.font = [UIFont systemFontOfSize:20.0];
    // 输入框背景色
    self.textView.backgroundColor = [UIColor whiteColor];
    // 已有事务内容
    self.textView.text = _agency;
    //将输入框添加到视图中
    [self.view addSubview:self.textView];
}

/**
 *  数据读取
 */
- (void) getData {
    // 获取应用程序沙盒的Documents目录,完整的文件名
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:@"/agency.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    // 事务内容
    if (data[_dateStr]) {
        // 如果本地存在数据缓存则用本地数据设置事务内容
        _agency = data[_dateStr];
    }else {
        // 否则如果没有缓存则请求服务器数据，并缓存到本地
        // ... ...
    }
}

/**
 * 保存新事务纪录
 */
- (void)saveAgency {
    // 退出键盘
    [self.view endEditing:YES];
    // 文件管理器判断沙盒路径是否存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    /* 1.事务存储到本地沙盒 */
    // 获取应用程序沙盒的Documents目录,完整的文件名
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:@"/agency.plist"];
    NSMutableDictionary *newData;
    if ([fileManager fileExistsAtPath:filename]) {
        // 沙盒路径存在则从沙盒读取数据
        newData = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    }else {
        // 如果是第一次添加事务沙盒为空，则新建一个字典写入沙盒
        newData = [[NSMutableDictionary alloc] init];
    }
    // 添加或者修改事务
    [newData setObject:_textView.text forKey:_dateStr];
    //输入写入沙盒
    [newData writeToFile:filename atomically:YES];
    
    /* 2.事务上传到服务器 */
    // ... ...
    
    // 3.设置日期按钮事务标记
    if([_textView.text isEqualToString:@""]) {
        // 事务为空
        [_sender setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }else {
        [_sender setBackgroundImage:[UIImage imageNamed:@"agencyMark"] forState:UIControlStateNormal];
    }
}

@end
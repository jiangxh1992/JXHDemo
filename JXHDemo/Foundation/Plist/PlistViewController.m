//
//  PlistViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 11/22/15.
//  Copyright © 2015 Jiangxh. All rights reserved.
//

#import "PlistViewController.h"

@interface PlistViewController ()

@end

@implementation PlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.读取工程中的plist文件，这里设置的工程的plist是一个字典，也可以用数组plist
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"plist"]];
    // 添加新数据到字典对象中
    [data setObject:@"sdbgbesdgjkds" forKey:@"d"];
    // 获取沙盒路径,这里"/demo.plist"是指新建的沙盒里plist文件路径，一定要加“/”!!!
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:@"/demo.plist"];
    // 将工程中的数据新字典写入沙盒
    [data writeToFile:filePath atomically:YES];
    NSLog(@"d:%@", [data objectForKey:@"d"]);
}

@end
//
//  AlertViewController.m
//  Demo
//
//  Created by 919575700@qq.com on 10/15/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//

#import "AlertViewController.h"
@interface AlertViewController ()

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UIButton *alertBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 320, 40)];
    [alertBtn setTitle:@"点我啊，我会alert" forState:UIControlStateNormal];
    alertBtn.backgroundColor = [UIColor redColor];
    [alertBtn addTarget:self action:@selector(alertBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertBtn];
}

- (void) alertBtnTapped {
    NSString *msg = @"1.第一行我是3个子\n2.第二行我是好几个字反正目的是为了和第一行区分开来\n3.哈哈我是陪衬的1.第一行我是3个子\n2.第二行我是好几个字反正目的是为了和第一行区分开来\n3.哈哈我是陪衬的";
    //[self showAlertWithMessage:msg Title:@"title"];
}
/**
 * 用标题和内容显示提示框
 */
- (void) showAlertWithMessage:(NSString *) message Title:(NSString *)title {
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        //提示框内容设置
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"title" message:message preferredStyle:UIAlertControllerStyleAlert];
        //
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        //内容居左
        paragraphStyle.alignment = NSTextAlignmentLeft;
        //行间距
        paragraphStyle.lineSpacing = 5.0;
        //
        NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18.0], NSParagraphStyleAttributeName : paragraphStyle};
        NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:message];
        [attributedTitle addAttributes:attributes range:NSMakeRange(0, message.length)];
        [alertController setValue:attributedTitle forKey:@"attributedMessage"];//attributedTitle\attributedMessage
        //按钮1:左边按钮
        UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:@"取消"
                                                                 style: UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction *action) {
                                                                   UITextField *textField = alertController.textFields[0];
                                                                   NSLog(@"text was %@", textField.text);
                                                               }];
        //按钮2:右边按钮
        UIAlertAction *defaultAction2 = [UIAlertAction actionWithTitle:@"确定"
                                                                 style: UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction *action) {
                                                                   NSLog(@"ok btn");
                                                                   [alertController dismissViewControllerAnimated:YES completion:nil];
                                                               }];
        [alertController addAction:defaultAction1];
        [alertController addAction:defaultAction2];
        //添加textfield
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"folder name";
            textField.keyboardType = UIKeyboardTypeDefault;
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"text type text";
            textField.keyboardType = UIKeyboardTypeDefault;
        }];
        /*显示提示框*/
        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        [rootViewController presentViewController:alertController animated: YES completion: nil];
    }else{
        UIAlertView *tmpAlertView = [[UIAlertView alloc] initWithTitle:@"测试换行"
                                                               message:message
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:@"知道了", nil];
        //如果你的系统大于等于7.0
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            CGSize size = [message sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(240, 1000) lineBreakMode:NSLineBreakByTruncatingTail];
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240, size.height)];
            textLabel.font = [UIFont systemFontOfSize:15];
            textLabel.textColor = [UIColor blackColor];
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.lineBreakMode = NSLineBreakByWordWrapping;
            textLabel.numberOfLines = 0;
            textLabel.textAlignment = NSTextAlignmentLeft;
            textLabel.text = message;
            [tmpAlertView setValue:textLabel forKey:@"accessoryView"];
            //这个地方别忘了把alertview的message设为空
            tmpAlertView.message = @"";
        }
        [tmpAlertView show];
    }
}

@end
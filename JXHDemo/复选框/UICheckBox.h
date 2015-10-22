//
//  UICheckBox.h
//  demo
//
//  Created by txbydev3 on 15/9/23.
//  Copyright © 2015年 txbydev3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICheckBox : UIButton

/**
 *  复选框选中状态
 */
@property (nonatomic)BOOL isChecked;

/**
 *  用frame初始化checkbox按钮
 */
- (UICheckBox *)initWithFrame:(CGRect)frame;
/**
 *  设置未选中图片
 */
- (void)setNormalImage:(UIImage*)normalImage;
/**
 *  设置选中图片
 */
- (void)setSelectedImage:(UIImage*)selectedImage;
/**
 *  设置图片
 */
- (void)setImage:(UIImage*)normalImage andSelectedImage:(UIImage*)selectedImage;


/**
 *  用字符串设置未选中图片
 */
- (void)setNormalImageWithName:(NSString*)normalImageName;
/**
 *  用字符串设置选中图片
 */
- (void)setSelectedImageWithName:(NSString*)selectedImageName;
/**
 *  用字符串设置图片
 */
- (void)setImageWithName:(NSString*)normalImageName andSelectedName:(NSString*)selectedImageName;
/**
 *按钮点击事件，点击后取反按钮状态
 */
-(void)checkboxClick;
@end

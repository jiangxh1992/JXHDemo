//
//  UIColor+HexString.h
//  DT
//
//  Created by Ryan Nystrom on 2/5/13.
//
/*****************************************
  为UIColor添加自定义函数，用于编程时通过16进制
  字符串设置得到特定颜色，
  包括：#RGB,#ARGB,#RRGGBB,#AARRGGBB
 *****************************************/
#import <UIKit/UIKit.h>

@interface UIColor (HexString)

/**
 * 16进制字符串设置自定义颜色
 */
+ (UIColor *) colorWithHexString: (NSString *) hexString;

@end

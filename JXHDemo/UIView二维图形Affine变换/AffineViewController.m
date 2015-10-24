//
//  AffineViewController.m
//  JXHDemo
//
//  Created by 919575700@qq.com on 10/24/15.
//  Copyright (c) 2015 Jiangxh. All rights reserved.
//
/**
 *  UIView的Affine二维变换
 */
/**
 *  根本的变换基于计算机图形学二维矩阵变换的知识,需要根据需要改变二维变换的一个三维变换矩阵的参数来设置,基本变换用到CGAffineTransform三维矩阵的6个参数：
 *  view.transform = CGAffineTransformMake(CGFloat a, CGFloat b, CGFloat c, CGFloat d, CGFloat tx, CGFloat ty)
 *  |a  b  0|
 *  |c  d  0|
 *  |tx ty 1|
 *  几种基本变换矩阵如下：
 *  1.平移变换矩阵
 *  |1  0  0|
 *  |0  1  0|
 *  |tx ty 1|
 *  (tx,ty)为平移的坐标矢量，即x坐标平移tx，y坐标平移ty
 *  代码表示：CGAffineTransformMake(1, 0, 0, 1, tx, ty)
 *
 *  2.比例变换矩阵
 *  |a  0  0|
 *  |0  d  0|
 *  |0  0  1|
 *  a,d为横纵方向上变换的倍数,x方向上扩大a倍,y方向上扩大d倍
 *  代码表示：CGAffineTransformMake(a, 0, 0, d, 0, 0)
 *  特别的：
 *  当a == d == c时，即在x和y方向上扩大或缩小相同倍数c
 *  此时将矩阵除以c，行列式的值不变，所以图形整体上缩放c倍的变换矩阵为：
 *  |1  0   0 |
 *  |0  1   0 |
 *  |0  0  1/c|
 *  但是transform参数并没有1/c所在的变量，因此这里不能通过这个矩阵对图形进行整体缩放
 *
 *  3.旋转变换矩阵
 *  | cosB  sinB  0|
 *  |-sinB  cosB  0|
 *  | 0     0     1|
 *  B为旋转的角度，逆时针为正，顺时针为负
 *  当B为正时，即逆时针旋转：
 *  代码表示：CGAffineTransformMake(cos|B|,  sin|B|, -sin|B|, cos|B|, 0, 0)
 *  当B为负时，即顺时针旋转时：
 *  代码表示：CGAffineTransformMake(cos|B|, -sin|B|,  sin|B|, cos|B|, 0, 0)
 *
 *  4.反射变换矩阵：即让图形绕原点或者某个坐标轴反射
 *  4.1 绕原点反射，x和y都取反：
 *  |-1  0  0|
 *  | 0 -1  0|
 *  | 0  0  1|
 *  代码表示：CGAffineTransformMake(-1, 0, 0, -1, 0, 0)
 *  4.2 绕x轴反射x不变，y取反
 *  | 1  0  0|
 *  | 0 -1  0|
 *  | 0  0  1|
 *  代码表示：CGAffineTransformMake(1, 0, 0, -1, 0, 0)
 *  4.3 绕y轴反射x取反，y不变
 *  |-1  0  0|
 *  | 0  1  0|
 *  | 0  0  1|
 *  代码表示：CGAffineTransformMake(-1, 0, 0, 1, 0, 0)
 *  特别的问题：
 *  图形绕y = x和y = -x的反射变换矩阵？
 *
 *  5.错切变换矩阵
 *  |1  b  0|
 *  |c  1  0|
 *  |0  0  1|
 *  c为x方向上的错切参数，b为y方向上的错切参数
 *  代码表示：CGAffineTransformMake(1, b, c, 1, 0, 0)
 *
 *
 *  另外系统封装了几个常用的图形变换函数：（同时明确Cocoa坐标系原点在左上角）
 *  1.平移
 *  向右移动tx像素，向下移动ty像素：
 *  view.transform = CGAffineTransformMakeTranslation(tx,ty));
 *  2.缩放
 *  宽度a倍，高度d倍：
 *  view.transform = CGAffineTransformMakeScale(a,d));
 *  3.旋转
 *  旋转B角，逆时针B为正，顺时针B为负：
 *  view.transform = CGAffineTransformMakeRotation(B*(M_PI/180.0));
 *  4.翻转（绕图形对称轴翻转）
 *  左右翻转：
 *  view.transform = CGAffineTransformMakeScale(原CGAffineTransform对象,-1.0,1.0));
 *  上下翻转：
 *  view.transform = CGAffineTransformMakeScale(原CGAffineTransform对象,1.0,-1.0));
 *  5.两个变换的复合变换
 *  view.transform = CGAffineTransformContact(CGAffineTransform1,CGAffineTransform2);
 */
#import "AffineViewController.h"

@interface AffineViewController ()

@end

@implementation AffineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景色
    self.view.backgroundColor = RGBColor(230, 230, 230);
    
    // 测试二维图形变换
    [self transformTest];
}

/**
 *  测试二维图形变换
 */
- (void)transformTest {
    //定义一个UIView
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    //设置中心
    view.center = self.view.center;
    //颜色
    view.backgroundColor = [UIColor purpleColor];
    //显示
    [self.view addSubview:view];
    
    /**
     *  定义几种矩阵变换
     */
    
    /**
     *  定义几种系统函数变换
     */
    //逆时针旋转90度
    CGAffineTransform unClockWise90 = CGAffineTransformMakeRotation(90.0*(M_PI/180.0));
}

@end
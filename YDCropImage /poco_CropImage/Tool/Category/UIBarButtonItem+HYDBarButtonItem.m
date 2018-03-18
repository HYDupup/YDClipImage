//
//  UIBarButtonItem+HYDBarButtonItem.m
//  IOS_百思不得姐
//
//  Created by mac on 17/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIBarButtonItem+HYDBarButtonItem.h"

@implementation UIBarButtonItem (HYDBarButtonItem)
+(instancetype)initItem:(NSString *)image heightImage:(NSString *)heightImage select:(SEL)select target:(id)target{
    UIButton *Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [Btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Btn setImage:[UIImage imageNamed:heightImage] forState:UIControlStateHighlighted];
//    Btn.size = Btn.currentBackgroundImage.size;//按钮图片的大小
    //        //按钮文字自动布局
//    [Btn sizeToFit];
    //        //按钮内容水平对齐
    Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //        //强制设置偏移量
    Btn.contentEdgeInsets = UIEdgeInsetsMake(0, -40*VIEW_RATE, 0, 0);
    [Btn addTarget:target action:select forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc]initWithCustomView:Btn];
}


@end

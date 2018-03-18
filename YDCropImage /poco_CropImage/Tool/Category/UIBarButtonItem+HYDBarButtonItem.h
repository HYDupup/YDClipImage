//
//  UIBarButtonItem+HYDBarButtonItem.h
//  IOS_百思不得姐
//
//  Created by mac on 17/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HYDBarButtonItem)
+(instancetype)initItem:(NSString *)image heightImage:(NSString *)heightImage select:(SEL)select target:(id)target;

@end

//
//  UIView+HYDUIView.m
//  IOS_百思不得姐
//
//  Created by mac on 17/1/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIView+HYDUIView.h"

@implementation UIView (HYDUIView)

-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint rect = self.center;
    rect.x = centerX;
    self.center= rect;
}

-(void)setCenterY:(CGFloat)centerY{
    CGPoint rect = self.center;
    rect.y = centerY;
    self.center= rect;
}

-(CGSize)size{
    return self.frame.size;
}

-(CGFloat)x{
    return self.frame.origin.x;
}

-(CGFloat)y{
    return self.frame.origin.y;
}
-(CGFloat)width{
    return self.frame.size.width;
}
-(CGFloat)height{
    return self.frame.size.height;
}

-(CGFloat)centerX{
    return self.center.x;
}
-(CGFloat)centerY{
    return self.center.y;
}



@end

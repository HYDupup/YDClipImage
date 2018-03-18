//
//  CropOverlayLine.m
//  poco_CropImage
//
//  Created by mac on 17/7/28.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import "ClipOverlayLine.h"

@implementation ClipOverlayLine

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect bounds = self.bounds;
    if (bounds.size.width == 1) {
        CGFloat Delta = 32.0*VIEW_RATE - bounds.size.width;
        bounds = CGRectInset(bounds, -1*Delta, 0);
    }else if(bounds.size.height == 1){
        CGFloat Delta = 32.0*VIEW_RATE - bounds.size.height;
        bounds = CGRectInset(bounds, 0, -1*Delta);
    }
   
    return CGRectContainsPoint(bounds, point);
}

@end

//
//  CropOverlayDrag.m
//  poco_CropImage
//
//  Created by mac on 17/7/28.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import "ClipOverlayDrag.h"

@implementation ClipOverlayDrag

-(instancetype)initWithFrame:(CGRect)frame andImage:(NSString *)image{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.image = [UIImage imageNamed:image];
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect bounds = self.bounds;
    
    bounds = CGRectInset(bounds, -16.0f*VIEW_RATE, -16.0f*VIEW_RATE);
    
    return CGRectContainsPoint(bounds, point);
}

@end

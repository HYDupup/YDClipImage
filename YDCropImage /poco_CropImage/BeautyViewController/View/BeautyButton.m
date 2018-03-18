//
//  BeautyButton.m
//  poco_CropImage
//
//  Created by mac on 17/7/26.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import "BeautyButton.h"

@implementation BeautyButton


-(instancetype)initWithFrame:(CGRect)frame andImgae:(NSString *)image andHeigthImage:(NSString *)heightImage andTitle:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:heightImage] forState:UIControlStateHighlighted];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:HYDColour(125.0f, 127.0f, 128.0f) forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.height - 20*VIEW_RATE;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height - 20*VIEW_RATE;
    self.titleLabel.width = self.width;
    self.titleLabel.height = 20*VIEW_RATE;
    
}

@end

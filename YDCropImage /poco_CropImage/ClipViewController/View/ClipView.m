//
//  CropView.m
//  poco_CropImage
//
//  Created by mac on 17/7/26.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import "ClipView.h"
#import "UIImage+ClipImgae.h"

@interface ClipView()

@property (nonatomic,strong)UIImageView *initialImageView;//图片VIEW

@property (nonatomic,assign)CGFloat scale;

@property (nonatomic,strong)UIButton *rotateBtn;//旋转按钮
@property (nonatomic,assign)int rotateIndex;//旋转系数

@end

@implementation ClipView

-(instancetype)initWithFrame:(CGRect)frame andInitialImage:(UIImage *)initialImage andCropScale:(CGSize)cropScale{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        self.rotateIndex = 0;
        self.initialImage = initialImage;
        self.cropScale = cropScale;
        [self creatUI];
    }
    return self;
}

#pragma mark CreatUI
-(void)creatUI{
    [self creatInitialImageView];
    [self creatCropOverlayView];
    [self creatRotatBtn];
}

-(void)creatRotatBtn{
    self.rotateBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.height - 110*VIEW_RATE, 64*VIEW_RATE, 64*VIEW_RATE)];
    [self.rotateBtn setImage:[UIImage imageNamed:@"rotate"]  forState:UIControlStateNormal];
    [self.rotateBtn addTarget:self action:@selector(clickRotateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rotateBtn];
    
}

-(void)creatInitialImageView{
    CGRect rect = [self calculateRect:self.initialImage.size];
    self.initialImageView = [[UIImageView alloc]initWithFrame:rect];
    self.initialImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.initialImageView.image = self.initialImage;
    [self addSubview:self.initialImageView];
}

-(void)creatCropOverlayView{
    self.cropOverlayView = [[ClipOverlayView alloc]initWithFrame:self.initialImageView.frame andCropScale:self.cropScale];
    [self addSubview:self.cropOverlayView];
}

#pragma mark rotateBtn target
-(void)clickRotateBtn:(UIButton *)sender{
    CGSize rotateSize;
    sender.enabled = NO;
    self.cropOverlayView.alpha = 0;

    self.rotateIndex ++;
    if (self.rotateIndex == 4) {
        self.rotateIndex = 0;
    }
    
    if (self.rotateIndex%2 != 0) {
        rotateSize = CGSizeMake(self.initialImage.size.height, self.initialImage.size.width);
    }else{
        rotateSize = CGSizeMake(self.initialImage.size.width, self.initialImage.size.height);
    }
    
    static CGFloat scale;
    static CGRect oldRect;
    oldRect = self.initialImageView.frame;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.initialImageView.transform= CGAffineTransformMakeRotation(M_PI_2*self.rotateIndex);
        CGRect rect = [self calculateRect:rotateSize];
        self.initialImageView.frame = rect;
        
        scale = rect.size.height/oldRect.size.width;
        
    } completion:^(BOOL finished) {
        [self.cropOverlayView rotatingImage:self.initialImageView.frame andscale:scale];
        [UIView animateWithDuration:0.3 animations:^{
            self.cropOverlayView.alpha = 1;
        }completion:^(BOOL finished) {
            sender.enabled = YES;
        }];

      
    }];
}

//计算图片的位置
-(CGRect)calculateRect:(CGSize)size{
    CGFloat scale,scaleW,scaleH;
    CGFloat imageViewW,imageViewH;

    scaleW = size.width/self.width;
    scaleH = size.height/self.height;
    
    scale = fmax(scaleW, scaleH);
    imageViewW = size.width / scale;
    imageViewH = size.height / scale;
    
    self.scale = scale;
    
    CGFloat x = (self.width - imageViewW)/2;
    CGFloat y = (self.height - imageViewH)/2;
    
    CGRect lastRect = CGRectMake(x, y, imageViewW, imageViewH);
    return lastRect;
}



#pragma mark 裁剪图片
-(UIImage *)cropImgae{
    
    CGRect frame = self.cropOverlayView.cliprect;
    frame.origin.x = frame.origin.x * self.scale;
    frame.origin.y = frame.origin.y * self.scale;
    frame.size.width = frame.size.width * self.scale;
    frame.size.height = frame.size.height * self.scale;
    
    UIImage *image = [self.initialImage cropImgae:frame andScale:self.scale andAngle:self.rotateIndex];
    return image;

}


-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect bounds = self.bounds;
    
    bounds = CGRectInset(bounds, 0, -40*VIEW_RATE);
    
    return CGRectContainsPoint(bounds, point);
}

@end

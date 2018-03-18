//
//  CropOverlayView.m
//  poco_CropImage
//
//  Created by mac on 17/7/27.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import "ClipOverlayView.h"

@interface ClipOverlayView()

@end

CGFloat ClipOverlayDragWidth,minDragWidth,minDragHeight;


@implementation ClipOverlayView

-(instancetype)initWithFrame:(CGRect)frame andCropScale:(CGSize)cropScale{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        ClipOverlayDragWidth = 32.0f*VIEW_RATE;
        minDragWidth = 3*ClipOverlayDragWidth;
        minDragHeight = 3*ClipOverlayDragWidth;
        self.cropScale = cropScale;
        CGSize size = [self cropScale:self.cropScale];
        [self changeScale:size];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
            
    }
    return self;
}

#pragma mark 覆盖层的View 懒加载
-(UIView *)cliprectView{
    if (_cliprectView == nil) {
        _cliprectView = [[UIView alloc]init];
        [_cliprectView setBackgroundColor:[UIColor clearColor]];
        _cliprectView.alpha = 0.5f;
        _cliprectView.userInteractionEnabled = YES;
        [self insertSubview:_cliprectView atIndex:0];
        UIPanGestureRecognizer *cliprectPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(cliprectPan:)];
        [_cliprectView addGestureRecognizer:cliprectPan];
    }
    return _cliprectView;
}

#pragma mark 覆盖层的View
-(void)creatCliprectView{
    
    self.cliprectView.frame = self.cliprect;
    
}

-(void)cliprectPan:(UIPanGestureRecognizer *)recognizer{
    CGPoint translatedPoint = [recognizer translationInView:recognizer.view];
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            break;
        }
        case UIGestureRecognizerStateChanged:{
            
            recognizer.view.x = recognizer.view.x + translatedPoint.x;
            recognizer.view.y = recognizer.view.y + translatedPoint.y;
            
            if (recognizer.view.x < 0 ) {
                recognizer.view.x = 0;
            }
            if (recognizer.view.y < 0) {
                recognizer.view.y = 0;
            }
            if (recognizer.view.x > self.width - recognizer.view.width) {
                recognizer.view.x = self.width - recognizer.view.width;
            }
            if (recognizer.view.y > self.height - recognizer.view.height) {
                recognizer.view.y = self.height - recognizer.view.height;
            }
            
            //四个角
            self.leftTop.x = recognizer.view.x;
            self.leftTop.y = recognizer.view.y;
            self.rightTop.x = recognizer.view.x + recognizer.view.width - ClipOverlayDragWidth;
            self.rightTop.y = recognizer.view.y;
            self.leftBottom.x = recognizer.view.x;
            self.leftBottom.y = recognizer.view.y + recognizer.view.height - ClipOverlayDragWidth;
            self.rightBottom.x = recognizer.view.x + recognizer.view.width - ClipOverlayDragWidth;
            self.rightBottom.y = recognizer.view.y + recognizer.view.height - ClipOverlayDragWidth;
            
            //四条边
            [self creatLine];
            
            //阴影范围
            self.cliprect = CGRectMake(recognizer.view.x, recognizer.view.y , recognizer.view.width, recognizer.view.height);

            break;
        }
        case UIGestureRecognizerStateEnded:{
            break;
        }
        default:
            break;
    }
    [self setNeedsDisplay];
    [recognizer setTranslation:CGPointZero inView:self];
}

#pragma mark 四条边懒加载
-(ClipOverlayLine *)topLine{
    if (_topLine == nil) {
        _topLine = [[ClipOverlayLine alloc]init];
        _topLine.exclusiveTouch = YES;
        UIPanGestureRecognizer *topLinePan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panLine:)];
        [_topLine addGestureRecognizer:topLinePan];
        [self insertSubview:_topLine atIndex:0];
    }
    return _topLine;
}
-(ClipOverlayLine *)leftLine{
    if (_leftLine == nil) {
        _leftLine = [[ClipOverlayLine alloc]init];
        _leftLine.exclusiveTouch = YES;
        UIPanGestureRecognizer *leftLinePan  = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panLine:)];
        [_leftLine addGestureRecognizer:leftLinePan];
        [self insertSubview:_leftLine atIndex:0];
    }
    return _leftLine;
}
-(ClipOverlayLine *)rightLine{
    if (_rightLine == nil) {
        _rightLine = [[ClipOverlayLine alloc]init];
        _rightLine.exclusiveTouch = YES;
        UIPanGestureRecognizer *rightLinePan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panLine:)];
        [_rightLine addGestureRecognizer:rightLinePan];
        [self insertSubview:_rightLine atIndex:0];
    }
    return _rightLine;
}
-(ClipOverlayLine *)bottomLine{
    if (_bottomLine == nil) {
        _bottomLine = [[ClipOverlayLine alloc]init];
        _bottomLine.exclusiveTouch = YES;
        UIPanGestureRecognizer *bottomLinePan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panLine:)];
        [_bottomLine addGestureRecognizer:bottomLinePan];
        [self insertSubview:_bottomLine atIndex:0];
    }
    return _bottomLine;
}

#pragma mark 四条边
-(void)creatLine{
    
    self.topLine.frame = CGRectMake(self.leftTop.x+2*ClipOverlayDragWidth, self.leftTop.y, self.rightTop.x-3*ClipOverlayDragWidth-self.leftTop.x, 1);
    
    self.leftLine.frame = CGRectMake(self.leftTop.x, self.leftTop.y+2*ClipOverlayDragWidth, 1, self.leftBottom.y-3*ClipOverlayDragWidth-self.leftTop.y);
    
    self.rightLine.frame = CGRectMake(self.rightTop.x+self.rightTop.width-1, self.rightTop.y+2*ClipOverlayDragWidth, 1, self.rightBottom.y-3*ClipOverlayDragWidth-self.rightTop.y);
    
    self.bottomLine.frame = CGRectMake(self.leftBottom.x+2*ClipOverlayDragWidth, self.leftBottom.y+self.leftBottom.height-1, self.rightBottom.x-3*ClipOverlayDragWidth-self.leftBottom.x, 1);
    
}

-(void)panLine:(UIPanGestureRecognizer *)recognizer{
    CGPoint translatedPoint = [recognizer translationInView:recognizer.view];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            break;
        }
        case UIGestureRecognizerStateChanged:{
            
            if (recognizer.view == self.topLine) {
                
                CGFloat translatedPointY = translatedPoint.y;
                CGFloat translatedPointX = translatedPointY * (self.cropScale.width/self.cropScale.height);
    
                if (self.cropScale.width == 0 && self.cropScale.height == 0) {
                    
                    self.leftTop.y = self.leftTop.y + translatedPointY;
                    self.rightTop.y = self.rightTop.y + translatedPointY;
                    
                    [self Locationestimation:self.leftTop];
                    [self Locationestimation:self.rightTop];
                    
                    self.cliprect = CGRectMake(self.leftTop.x, self.leftTop.y, self.rightTop.x+self.rightTop.width-self.leftTop.x, self.leftBottom.y+self.leftBottom.height-self.leftTop.y);
                    self.cliprectView.frame = self.cliprect;
                    [self creatLine];
                    
                }else{
                    
                    CGRect frame = self.cliprect;
                    frame.origin.x = frame.origin.x + translatedPointX/2;
                    frame.origin.y = frame.origin.y + translatedPointY;
                    frame.size.width = frame.size.width - translatedPointX;
                    frame.size.height = frame.size.height - translatedPointY;
                    
                   if ((frame.size.width <= minDragWidth && frame.size.height <= minDragHeight) || (frame.size.width >= self.mainClipSize.width && frame.size.height >= self.mainClipSize.height)) {
                    
                       break;
                   }
                    
                    if (frame.origin.x < 0 || frame.origin.y < 0 || frame.origin.x + frame.size.width >= self.width) {
                        if (frame.origin.x < 0 && frame.origin.y < 0 ) {
                            frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
                        }else if (frame.origin.y < 0 && frame.origin.x + frame.size.width >= self.width){
                            frame = CGRectMake(frame.origin.x + translatedPointX/2, 0, frame.size.width, frame.size.height);
                        }else if (frame.origin.x < 0) {
                            frame = CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height);
                        }else if (frame.origin.y < 0){
                            frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
                        }else if (frame.origin.x + frame.size.width >= self.width){
                            frame = CGRectMake(frame.origin.x + translatedPointX/2, frame.origin.y, frame.size.width, frame.size.height);
                        }
                    }

                    self.cliprect = frame;
                    self.cliprectView.frame = self.cliprect;
                    [self creatQuadrangle];
                }
            
            }
            
            if (recognizer.view == self.leftLine) {
                
                CGFloat translatedPointX = translatedPoint.x;
                CGFloat translatedPointY = translatedPointX / (self.cropScale.width/self.cropScale.height);
                
                if (self.cropScale.width == 0 && self.cropScale.height == 0) {
                    
                    self.leftTop.x = self.leftTop.x + translatedPointX;
                    self.leftBottom.x = self.leftBottom.x + translatedPointX;
                    
                    [self Locationestimation:self.leftTop];
                    [self Locationestimation:self.leftBottom];
                    
                    self.cliprect = CGRectMake(self.leftTop.x, self.leftTop.y, self.rightTop.x+self.rightTop.width-self.leftTop.x, self.leftBottom.y+self.leftBottom.height-self.leftTop.y);
                    self.cliprectView.frame = self.cliprect;
                    [self creatLine];
                    
                }else{
                    
                    CGRect frame = self.cliprect;
                    frame.origin.x = frame.origin.x + translatedPointX;
                    frame.origin.y = frame.origin.y + translatedPointY/2;
                    frame.size.width = frame.size.width - translatedPointX;
                    frame.size.height = frame.size.height - translatedPointY;
                    
                    
                    if ((frame.size.width <= minDragWidth && frame.size.height <= minDragHeight) || (frame.size.width >= self.mainClipSize.width && frame.size.height >= self.mainClipSize.height)) {
                        
                        break;
                    }
                    
                    if (frame.origin.x < 0 || frame.origin.y < 0 || frame.origin.y + frame.size.height >= self.height) {
                        if (frame.origin.x < 0 && frame.origin.y < 0 ) {
                            frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
                        }else if (frame.origin.x < 0 && frame.origin.y + frame.size.height >= self.height){
                            frame = CGRectMake(0, frame.origin.y + translatedPointY/2, frame.size.width, frame.size.height);
                        }else if (frame.origin.x < 0) {
                            frame = CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height);
                        }else if (frame.origin.y < 0){
                            frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
                        }else if (frame.origin.y + frame.size.height >= self.height){
                            frame = CGRectMake(frame.origin.x, frame.origin.y + translatedPointY/2, frame.size.width, frame.size.height);
                        }
                    }
                    
                    self.cliprect = frame;
                    self.cliprectView.frame = self.cliprect;
                    [self creatQuadrangle];
                    
                }
                
            }
            
            if (recognizer.view == self.rightLine) {
                
                CGFloat translatedPointX = translatedPoint.x;
                CGFloat translatedPointY = translatedPointX / (self.cropScale.width/self.cropScale.height);
                
                if (self.cropScale.width == 0 && self.cropScale.height == 0) {
                    
                    self.rightTop.x = self.rightTop.x + translatedPointX;
                    self.rightBottom.x = self.rightBottom.x + translatedPointX;
                    
                    [self Locationestimation:self.rightTop];
                    [self Locationestimation:self.rightBottom];
                    
                    self.cliprect = CGRectMake(self.leftTop.x, self.leftTop.y, self.rightTop.x+self.rightTop.width-self.leftTop.x, self.leftBottom.y+self.leftBottom.height-self.leftTop.y);
                    self.cliprectView.frame = self.cliprect;
                    [self creatLine];
                    
                }else{
                    
                    CGRect frame = self.cliprect;
                    frame.origin.x = frame.origin.x;
                    frame.origin.y = frame.origin.y - translatedPointY/2;
                    frame.size.width = frame.size.width + translatedPointX;
                    frame.size.height = frame.size.height + translatedPointY;
                    
                    
                    if ((frame.size.width <= minDragWidth && frame.size.height <= minDragHeight) || (frame.size.width >= self.mainClipSize.width && frame.size.height >= self.mainClipSize.height)) {
                        
                        break;
                    }
                    
                    if (frame.origin.y < 0 || frame.origin.y + frame.size.height >= self.height || frame.origin.x + frame.size.width >= self.width) {
                        if (frame.origin.y < 0 && frame.origin.x + frame.size.width >= self.width) {
                            frame = CGRectMake(frame.origin.x - translatedPointX, 0 , frame.size.width, frame.size.height);
                        }else if (frame.origin.y + frame.size.height >= self.height && frame.origin.x + frame.size.width >= self.width){
                            frame = CGRectMake(frame.origin.x - translatedPointX, frame.origin.y - translatedPointY/2, frame.size.width, frame.size.height);
                        }else if (frame.origin.y < 0) {
                            frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
                        }else if (frame.origin.y + frame.size.height >= self.height){
                            frame = CGRectMake(frame.origin.x , frame.origin.y - translatedPointY/2, frame.size.width, frame.size.height);
                        }else if ( frame.origin.x + frame.size.width >= self.width){
                            frame = CGRectMake(frame.origin.x - translatedPointX, frame.origin.y , frame.size.width, frame.size.height);
                        }
                    }
                    
                    self.cliprect = frame;
                    self.cliprectView.frame = self.cliprect;
                    [self creatQuadrangle];
                    
                }

            }
            
            if (recognizer.view == self.bottomLine) {
                
                CGFloat translatedPointY = translatedPoint.y;
                CGFloat translatedPointX = translatedPointY * (self.cropScale.width/self.cropScale.height);
                
                if (self.cropScale.width == 0 && self.cropScale.height == 0) {
                    
                    self.leftBottom.y = self.leftBottom.y + translatedPointY;
                    self.rightBottom.y = self.rightBottom.y + translatedPointY;
                    
                    [self Locationestimation:self.leftBottom];
                    [self Locationestimation:self.rightBottom];
                    
                    self.cliprect = CGRectMake(self.leftTop.x, self.leftTop.y, self.rightTop.x+self.rightTop.width-self.leftTop.x, self.leftBottom.y+self.leftBottom.height-self.leftTop.y);
                    self.cliprectView.frame = self.cliprect;
                    [self creatLine];
                    
                }else{
                    
                    CGRect frame = self.cliprect;
                    frame.origin.x = frame.origin.x - translatedPointX/2;
                    frame.origin.y = frame.origin.y;
                    frame.size.width = frame.size.width + translatedPointX;
                    frame.size.height = frame.size.height + translatedPointY;
                    
                    if ((frame.size.width <= minDragWidth && frame.size.height <= minDragHeight) || (frame.size.width >= self.mainClipSize.width && frame.size.height >= self.mainClipSize.height)) {
                        
                        break;
                    }
                    
                    if (frame.origin.x < 0 || CGRectGetMaxX(frame) >= self.width || CGRectGetMaxY(frame) >= self.height) {
                        if (frame.origin.x < 0 && CGRectGetMaxY(frame) >= self.height) {
                            frame = CGRectMake(0, frame.origin.y - translatedPointY, frame.size.width, frame.size.height);
                        }else if (CGRectGetMaxX(frame) >= self.width && CGRectGetMaxY(frame) >= self.height){
                            frame = CGRectMake(frame.origin.x - translatedPointX/2, frame.origin.y - translatedPointY, frame.size.width, frame.size.height);
                        }else if (frame.origin.x < 0) {
                            frame = CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height);
                        }else if (CGRectGetMaxX(frame) >= self.width){
                            frame = CGRectMake(frame.origin.x - translatedPointX/2, frame.origin.y, frame.size.width, frame.size.height);
                        }else if (CGRectGetMaxY(frame) >= self.height){
                            if ( frame.origin.y-translatedPointY < 0) {
                             frame = CGRectMake(frame.origin.x , 0, frame.size.width, frame.size.height);
                            }else{
                             frame = CGRectMake(frame.origin.x , frame.origin.y-translatedPointY, frame.size.width, frame.size.height);
                            }
                        }
                    }
   
                    self.cliprect = frame;
                    self.cliprectView.frame = self.cliprect;
                    [self creatQuadrangle];
                    
                }
                
            }

            break;
        }
        case UIGestureRecognizerStateEnded:{
            [self creatLine];
            break;
        }
        default:
            break;
    }
    [self setNeedsDisplay];
    [recognizer setTranslation:CGPointZero inView:self];
}

#pragma mark 四个角懒加载
-(ClipOverlayDrag *)leftTop{
    if (_leftTop == nil) {
        _leftTop = [[ClipOverlayDrag alloc]initWithFrame:CGRectMake(0, 0, 0, 0) andImage:@"leftTop"];
        _leftTop.exclusiveTouch = YES;
        UIPanGestureRecognizer *leftToppan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [_leftTop addGestureRecognizer:leftToppan];
        [self addSubview:_leftTop];
    }
    return _leftTop;
}
-(ClipOverlayDrag *)rightTop{
    if (_rightTop == nil) {
        _rightTop = [[ClipOverlayDrag alloc]initWithFrame:CGRectMake(0, 0, 0, 0) andImage:@"rightTop"];
        _rightTop.exclusiveTouch = YES;
        UIPanGestureRecognizer *rightToppan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [_rightTop addGestureRecognizer:rightToppan];
        [self addSubview:_rightTop];
    }
    return _rightTop;
}
-(ClipOverlayDrag *)leftBottom{
    if (_leftBottom == nil) {
        _leftBottom = [[ClipOverlayDrag alloc]initWithFrame:CGRectMake(0, 0, 0, 0) andImage:@"leftBottom"];
        UIPanGestureRecognizer *leftBottompan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [_leftBottom addGestureRecognizer:leftBottompan];
        _leftBottom.exclusiveTouch = YES;
        [self addSubview:_leftBottom];
    }
    return _leftBottom;
}
-(ClipOverlayDrag *)rightBottom{
    if (_rightBottom == nil) {
        _rightBottom = [[ClipOverlayDrag alloc]initWithFrame:CGRectMake(0, 0, 0, 0) andImage:@"rightBottom"];
        UIPanGestureRecognizer *rightBottompan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [_rightBottom addGestureRecognizer:rightBottompan];
        _rightBottom.exclusiveTouch = YES;
        [self addSubview:_rightBottom];
        
    }
    return _rightBottom;
}
#pragma mark 四个角
-(void)creatQuadrangle{
    
    self.leftTop.frame = CGRectMake(self.cliprect.origin.x, self.cliprect.origin.y,ClipOverlayDragWidth , ClipOverlayDragWidth);
  
    self.rightTop.frame = CGRectMake(self.cliprect.origin.x + self.cliprect.size.width -ClipOverlayDragWidth, self.cliprect.origin.y, ClipOverlayDragWidth, ClipOverlayDragWidth);
    
  
    self.leftBottom.frame = CGRectMake(self.cliprect.origin.x, self.cliprect.origin.y + self.cliprect.size.height - ClipOverlayDragWidth, ClipOverlayDragWidth, ClipOverlayDragWidth);
   
    self.rightBottom.frame = CGRectMake(self.cliprect.origin.x + self.cliprect.size.width -ClipOverlayDragWidth, self.cliprect.origin.y + self.cliprect.size.height - ClipOverlayDragWidth, ClipOverlayDragWidth, ClipOverlayDragWidth);
    
}

-(void)pan:(UIPanGestureRecognizer *)recognizer{
    CGPoint translatedPoint = [recognizer translationInView:recognizer.view];

    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            break;
        }
        case UIGestureRecognizerStateChanged:{

            if (self.cropScale.width == 0 && self.cropScale.height == 0) {
                
                recognizer.view.x = recognizer.view.x + translatedPoint.x;
                recognizer.view.y = recognizer.view.y + translatedPoint.y;
                
            }else{
                
                if (fabs(translatedPoint.x) > fabs(translatedPoint.y)) {
                    
                    recognizer.view.x = recognizer.view.x + translatedPoint.x;
                    
                    if (recognizer.view == self.leftTop || recognizer.view == self.rightBottom) {
                        recognizer.view.y = recognizer.view.y + translatedPoint.x/(self.cropScale.width/self.cropScale.height);
                    }else if (recognizer.view == self.leftBottom || recognizer.view == self.rightTop){
                        recognizer.view.y = recognizer.view.y - translatedPoint.x/(self.cropScale.width/self.cropScale.height);
                    }
                    
                }else{
                    
                    recognizer.view.y = recognizer.view.y + translatedPoint.y;
                    
                    if (recognizer.view == self.leftTop || recognizer.view == self.rightBottom) {
                        recognizer.view.x = recognizer.view.x + translatedPoint.y*(self.cropScale.width/self.cropScale.height);
                    }else if (recognizer.view == self.leftBottom || recognizer.view == self.rightTop){
                        recognizer.view.x = recognizer.view.x - translatedPoint.y*(self.cropScale.width/self.cropScale.height);
                    }
                    
                }
            }
            
            //左上角
            if (recognizer.view == self.leftTop) {
                
                [self Locationestimation:recognizer.view];
            
                self.leftBottom.x = self.leftTop.x;
                self.rightTop.y = self.leftTop.y;

            }
            
            //右上角
            if (recognizer.view == self.rightTop) {
                
                [self Locationestimation:recognizer.view];
                
                self.rightBottom.x = self.rightTop.x;
                self.leftTop.y = self.rightTop.y;
            }
            
            //左下角
            if (recognizer.view == self.leftBottom) {
                
                [self Locationestimation:recognizer.view];
                
                self.leftTop.x = self.leftBottom.x;
                self.rightBottom.y = self.leftBottom.y;
            }
            
            //右下角
            if (recognizer.view == self.rightBottom) {

                [self Locationestimation:recognizer.view];
                
                self.rightTop.x = self.rightBottom.x;
                self.leftBottom.y = self.rightBottom.y;
            }
            
            self.cliprect = CGRectMake(self.leftTop.x, self.leftTop.y, self.rightTop.x+self.rightTop.width-self.leftTop.x, self.leftBottom.y+self.leftBottom.height-self.leftTop.y);
            self.cliprectView.frame = self.cliprect;
            [self creatLine];

            break;
        }
        case UIGestureRecognizerStateEnded:{
            break;
        }
        default:
            break;
    }
    [self setNeedsDisplay];
    [recognizer setTranslation:CGPointZero inView:self];
}

//位置判断
-(void)Locationestimation:(UIView *)view{
    //左上角
    if (view == self.leftTop) {
        
        if (view.x > self.rightBottom.x - minDragWidth + ClipOverlayDragWidth) {
            view.x = self.rightBottom.x  - minDragWidth + ClipOverlayDragWidth;
        }
        if (view.x < self.rightBottom.x + ClipOverlayDragWidth - self.mainClipSize.width) {
            view.x = self.rightBottom.x + ClipOverlayDragWidth - self.mainClipSize.width;
        }
        if (view.y > self.rightBottom.y - minDragHeight + ClipOverlayDragWidth) {
            view.y = self.rightBottom.y - minDragHeight + ClipOverlayDragWidth;
        }
        if (view.y < self.rightBottom.y + ClipOverlayDragWidth - self.mainClipSize.height) {
            view.y = self.rightBottom.y + ClipOverlayDragWidth - self.mainClipSize.height;
        }
        
        if (view.x < 0 || view.y < 0) {
            if (view.x < 0) {
                view.x = 0;
                view.y = self.rightTop.y;
            }else if (view.y < 0){
                view.y = 0;
                view.x = self.leftBottom.x;
            }
        }
        
    }
    
    //右上角
    if (view == self.rightTop) {
        
        if (view.x > self.leftBottom.x + self.mainClipSize.width - ClipOverlayDragWidth) {
            view.x = self.leftBottom.x + self.mainClipSize.width - ClipOverlayDragWidth;
        }
        if (view.x < self.leftBottom.x + minDragWidth - ClipOverlayDragWidth) {
            view.x = self.leftBottom.x + minDragWidth - ClipOverlayDragWidth;
        }
        if (view.y > self.leftBottom.y - minDragHeight + ClipOverlayDragWidth) {
            view.y = self.leftBottom.y - minDragHeight + ClipOverlayDragWidth;
        }
        if (view.y < self.leftBottom.y + ClipOverlayDragWidth - self.mainClipSize.height) {
            view.y = self.leftBottom.y + ClipOverlayDragWidth - self.mainClipSize.height;
        }
        
        if (view.x > self.width - ClipOverlayDragWidth ||
            view.y < 0) {
            if (view.x > self.width - ClipOverlayDragWidth) {
                view.x = self.width - ClipOverlayDragWidth;
                view.y = self.leftTop.y;
            }else if (view.y < 0){
                view.y = 0;
                view.x = self.rightBottom.x;
            }
        }
    }
    
    //左下角
    if (view == self.leftBottom) {
        
        if (view.x > self.rightTop.x - minDragWidth + ClipOverlayDragWidth) {
            view.x = self.rightTop.x - minDragWidth + ClipOverlayDragWidth;
        }
        if (view.x < self.rightTop.x + ClipOverlayDragWidth - self.mainClipSize.width) {
            view.x = self.rightTop.x + ClipOverlayDragWidth - self.mainClipSize.width;
        }
        if (view.y > self.rightTop.y + self.mainClipSize.height - ClipOverlayDragWidth) {
            view.y = self.rightTop.y + self.mainClipSize.height - ClipOverlayDragWidth;
        }
        if (view.y < self.rightTop.y + minDragHeight - ClipOverlayDragWidth) {
            view.y = self.rightTop.y + minDragHeight - ClipOverlayDragWidth;
        }
        
        if (view.x < 0 || view.y > self.height - ClipOverlayDragWidth) {
            if (view.x < 0) {
                view.x = 0;
                view.y = self.rightBottom.y;
            }else if (view.y > self.height - ClipOverlayDragWidth){
                view.y = self.height- ClipOverlayDragWidth;
                view.x = self.leftTop.x;
            }
        }
        
        self.leftTop.x = view.x;
        self.rightBottom.y = view.y;
    }
    
    //右下角
    if (view == self.rightBottom) {
        
        if (view.x > self.leftTop.x + self.mainClipSize.width - ClipOverlayDragWidth) {
            view.x = self.leftTop.x + self.mainClipSize.width - ClipOverlayDragWidth;
        }
        
        if (view.x < self.leftTop.x + minDragWidth - ClipOverlayDragWidth) {
            view.x = self.leftTop.x + minDragWidth - ClipOverlayDragWidth;
        }
        
        if (view.y > self.leftTop.y + self.mainClipSize.height - ClipOverlayDragWidth) {
            view.y = self.leftTop.y + self.mainClipSize.height - ClipOverlayDragWidth;
        }
        
        if (view.y < self.leftTop.y + minDragHeight - ClipOverlayDragWidth) {
            view.y = self.leftTop.y + minDragHeight - ClipOverlayDragWidth;
        }
        
        if (view.x > self.width - ClipOverlayDragWidth ||
            view.y > self.height - ClipOverlayDragWidth) {
            if (view.x > self.width - ClipOverlayDragWidth) {
                view.x = self.width - ClipOverlayDragWidth;
                view.y = self.leftBottom.y;
            }else if (view.y > self.height - ClipOverlayDragWidth){
                view.y = self.height - ClipOverlayDragWidth;
                view.x = self.rightTop.x;
            }
        }
    }

}

#pragma mark 画线
-(void)drawRect:(CGRect)rect{

    //阴影
    [self shadow];
    
    //竖线
    [self vertical];
   
    //横线
    [self horizontal];
}

//阴影
-(void)shadow{
    //  裁剪框外部阴影
    CGContextRef context = UIGraphicsGetCurrentContext();    //初始化图形上下文
    CGContextSetFillColorWithColor(context,[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]CGColor]);
    //是画阴影的
    CGRect shadow = CGRectMake(0, 0, self.width, self.cliprect.origin.y + 0.05);
    CGContextFillRect(context, shadow);
    
    shadow = CGRectMake(0, self.cliprect.origin.y, self.cliprect.origin.x, self.cliprect.size.height);
    CGContextFillRect(context, shadow);
    
    shadow = CGRectMake( self.cliprect.origin.x+self.cliprect.size.width, self.cliprect.origin.y,self.width - self.cliprect.origin.x + self.cliprect.size.width, self.cliprect.size.height);
    CGContextFillRect(context, shadow);
    
    shadow = CGRectMake(0, self.cliprect.origin.y + self.cliprect.size.height-0.05, self.width,self.height-self.cliprect.origin.y-self.cliprect.size.height+0.05);
    CGContextFillRect(context, shadow);
}

//竖线
-(void)vertical{
    //竖线间隔
    CGFloat verticalInterval = (self.rightTop.x+self.rightTop.width - self.leftTop.x)/6;
    
    NSMutableArray *fromVerticalIintervals = [[NSMutableArray alloc]init];
    for (int i=0; i<7; i++) {
        CGFloat x = self.leftTop.x + i*verticalInterval;
        CGFloat y = self.leftTop.y;
        [fromVerticalIintervals addObject:NSStringFromCGPoint(CGPointMake(x, y))];
    }
    NSMutableArray *toVerticalIintervals = [[NSMutableArray alloc]init];
    for (int i=0; i<7; i++) {
        CGFloat x = self.leftBottom.x + i*verticalInterval;
        CGFloat y = self.leftBottom.y + self.leftBottom.height;
        [toVerticalIintervals addObject:NSStringFromCGPoint(CGPointMake(x, y))];
    }
    for (int i=0; i<7; i++) {
        [self paintLine:CGPointFromString(fromVerticalIintervals[i]).x andFrom:CGPointFromString(fromVerticalIintervals[i]).y andToX:CGPointFromString(toVerticalIintervals[i]).x andToY:CGPointFromString(toVerticalIintervals[i]).y];
    }
}

//横线
-(void)horizontal{
    //横线间隔
    CGFloat horizontal = (self.leftBottom.y+self.leftBottom.height - self.leftTop.y)/6;
    
    NSMutableArray *fromHorizontals = [[NSMutableArray alloc]init];
    for (int i=0; i<7; i++) {
        CGFloat x = self.leftTop.x;
        CGFloat y = self.leftTop.y + i*horizontal;
        [fromHorizontals addObject:NSStringFromCGPoint(CGPointMake(x, y))];
    }
    NSMutableArray *toHorizontals = [[NSMutableArray alloc]init];
    for (int i=0; i<7; i++) {
        CGFloat x = self.rightTop.x + self.leftBottom.width;
        CGFloat y = self.rightTop.y + i*horizontal;
        [toHorizontals addObject:NSStringFromCGPoint(CGPointMake(x, y))];
    }
    for (int i=0; i<7; i++) {
        [self paintLine:CGPointFromString(fromHorizontals[i]).x andFrom:CGPointFromString(fromHorizontals[i]).y andToX:CGPointFromString(toHorizontals[i]).x andToY:CGPointFromString(toHorizontals[i]).y];
    }
}

//画线
-(void)paintLine:(CGFloat)formX andFrom:(CGFloat)fromY andToX:(CGFloat)ToX andToY:(CGFloat)ToY{
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, 1.0);
    //设置颜色
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    //开始一个起始路径
    CGContextBeginPath(context);
    //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
    CGContextMoveToPoint(context, formX, fromY);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, ToX, ToY);
    //连接上面定义的坐标点
    CGContextStrokePath(context);
}

#pragma mark 裁剪比例方法
-(CGSize)cropScale:(CGSize)cropScale{
    
    self.cropScale = cropScale;
    
    if (self.cropScale.width == 0 && self.cropScale.height == 0) {
        
        minDragWidth = 4*ClipOverlayDragWidth;
        minDragHeight = 4*ClipOverlayDragWidth;
        
    }else{
        
        if (self.cropScale.width >= self.self.cropScale.height) {
            
            minDragHeight = 4*ClipOverlayDragWidth;
            minDragWidth = minDragHeight*(self.cropScale.width /self.cropScale.height);
            
        }else if (self.cropScale.height > self.cropScale.width){
            
            minDragWidth = 4*ClipOverlayDragWidth;
            minDragHeight = minDragWidth/(self.cropScale.width /self.cropScale.height);
        }
    }
    
    CGFloat cliprectW = 0,cliprectH = 0;
    
    if (cropScale.width == 0 && cropScale.height == 0) {
        cliprectW = self.width;
        cliprectH = self.height;
    }else if (cropScale.width > 0 && cropScale.height > 0){
        if ((CGFloat)(self.width/self.height) == (CGFloat)(cropScale.width/cropScale.height)) {
            cliprectW = self.width;
            cliprectH = self.height;
        }else if((CGFloat)(self.width/self.height) > (CGFloat)(cropScale.width/cropScale.height)){
            cliprectH = self.height;
            cliprectW = cliprectH * (cropScale.width/cropScale.height);
        }else if((CGFloat)(self.width/self.height) < (CGFloat)(cropScale.width/cropScale.height)){
            cliprectW = self.width;
            cliprectH = cliprectW / (cropScale.width/cropScale.height);
        }
    }
    
    
    CGSize size = CGSizeMake(cliprectW, cliprectH);
    return size;
}

-(void)changeScale:(CGSize)size{
    
    self.cliprect = CGRectMake((self.width-size.width)/2, (self.height-size.height)/2, size.width, size.height);
    self.mainClipSize = CGSizeMake(size.width, size.height);
    
    //四个角
    [self creatQuadrangle];
    
    //四条边
    [self creatLine];
    
    //覆盖层
    [self creatCliprectView];
    
    [self setNeedsDisplay];
}

#pragma mark 旋转图片之后
-(void)rotatingImage:(CGRect)newFrame andscale:(CGFloat)scale{
    
    self.frame = newFrame;

    self.cliprect = CGRectMake(newFrame.size.width - self.cliprect.origin.y*scale - self.cliprect.size.height*scale, self.cliprect.origin.x*scale, self.cliprect.size.height*scale, self.cliprect.size.width*scale);
    
    self.cropScale = CGSizeMake(self.cropScale.height, self.cropScale.width);
    CGSize size = [self cropScale:self.cropScale];
    
    self.mainClipSize = size;
    
    [self creatQuadrangle];
    [self creatLine];
    [self creatCliprectView];
    
    [self setNeedsDisplay];
}


-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect bounds = self.bounds;
    
    bounds = CGRectInset(bounds, -40*VIEW_RATE, -40*VIEW_RATE);
        
    return CGRectContainsPoint(bounds, point);
}

@end

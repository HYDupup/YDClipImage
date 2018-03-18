//
//  CropOverlayView.h
//  poco_CropImage
//
//  Created by mac on 17/7/27.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClipOverlayDrag.h"
#import "ClipOverlayLine.h"

@interface ClipOverlayView : UIView

-(instancetype)initWithFrame:(CGRect)frame andCropScale:(CGSize)cropScale;

//四个拖动图片
@property (nonatomic,strong)ClipOverlayDrag *leftTop;
@property (nonatomic,strong)ClipOverlayDrag *rightTop;
@property (nonatomic,strong)ClipOverlayDrag *leftBottom;
@property (nonatomic,strong)ClipOverlayDrag *rightBottom;

//四个边
@property (nonatomic,strong)ClipOverlayLine *topLine;
@property (nonatomic,strong)ClipOverlayLine *leftLine;
@property (nonatomic,strong)ClipOverlayLine *rightLine;
@property (nonatomic,strong)ClipOverlayLine *bottomLine;

//覆盖层 裁剪
@property (nonatomic,strong)UIView *cliprectView;
//覆盖层 裁剪的rect
@property (nonatomic,assign)CGRect cliprect;

//覆盖层 裁剪的最大范围
@property (nonatomic,assign)CGSize mainClipSize;

//当前的裁剪比例
@property (nonatomic,assign)CGSize cropScale;

/*
 设置裁剪比例方法
 */
-(CGSize)cropScale:(CGSize)size;

/*
 改变裁剪比例后重新布局
 */
-(void)changeScale:(CGSize)size;

/*
 旋转之后重绘
 */
-(void)rotatingImage:(CGRect)newFrame andscale:(CGFloat)scale;

@end

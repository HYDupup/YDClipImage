//
//  CropView.h
//  poco_CropImage
//
//  Created by mac on 17/7/26.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClipOverlayView.h"

@interface ClipView : UIView

/**
 覆盖层
 */
@property (nonatomic,strong)ClipOverlayView *cropOverlayView;

/**
 原图
 */
@property (nonatomic,strong)UIImage *initialImage;

/**
 裁剪的比例类型
 */
@property (nonatomic,assign)CGSize cropScale;

/*
 initialImage 原始的图片
 cropScale 默认的裁剪比例 3:2则cropScale=CGSizeMake(3, 2)  任意为 CGSizeMake(0, 0)
*/
-(instancetype)initWithFrame:(CGRect)frame andInitialImage:(UIImage *)initialImage andCropScale:(CGSize)cropScale;

/*
 裁剪图片
 */
-(UIImage *)cropImgae;

@end

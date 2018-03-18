//
//  UIImage+CropImgae.h
//  poco_CropImage
//
//  Created by mac on 17/8/7.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ClipImgae)

-(UIImage *)cropImgae:(CGRect)cropRect andScale:(CGFloat)scale andAngle:(NSInteger)angle;

@end

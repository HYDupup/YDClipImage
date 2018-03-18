//
//  UIImage+CropImgae.m
//  poco_CropImage
//
//  Created by mac on 17/8/7.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import "UIImage+ClipImgae.h"

@implementation UIImage (ClipImgae)

-(UIImage *)cropImgae:(CGRect)cropRect andScale:(CGFloat)scale andAngle:(NSInteger)angle{
    
    NSLog(@"cropRect=%@",NSStringFromCGRect(cropRect));
    NSLog(@"image.size = %@",NSStringFromCGSize(self.size));
    UIImage *croppedImage = nil;
    CGPoint drawPoint = CGPointZero;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(cropRect.size.width, cropRect.size.height), YES, scale);
  
    CGContextRef context = UIGraphicsGetCurrentContext();

     if (angle != 0) {
//            UIImageView *imageView = [[UIImageView alloc] initWithImage:self];
//            imageView.layer.minificationFilter = @"nearest";
//            imageView.layer.magnificationFilter = @"neareset";
//            imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2*angle);
//            CGRect rotatedRect = CGRectApplyAffineTransform(imageView.bounds, imageView.transform);
//            UIView *containerView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, rotatedRect.size}];
//            [containerView addSubview:imageView];
//            imageView.center = containerView.center;
//            CGContextTranslateCTM(context, -cropRect.origin.x, -cropRect.origin.y);
//            [imageView.layer renderInContext:context];
       
         CGContextRotateCTM(context, M_PI_2*angle);
         if (angle == 1) {
             CGContextScaleCTM(context, 1, -1);
             CGContextTranslateCTM(context, -cropRect.origin.y, -cropRect.origin.x);
         }else if (angle == 2){
             CGContextScaleCTM(context, 1, -1);
             CGContextTranslateCTM(context, -self.size.width, 0);
             CGContextTranslateCTM(context, cropRect.origin.x, -cropRect.origin.y);
         }else if (angle == 3){
             CGContextScaleCTM(context, 1, -1);
             CGContextTranslateCTM(context, -self.size.width, -self.size.height);
             CGContextTranslateCTM(context, cropRect.origin.y, cropRect.origin.x);
         }
         CGContextDrawImage(context, CGRectMake(drawPoint.x, drawPoint.y, self.size.width, self.size.height), self.CGImage);
        }
        else {
//            CGContextTranslateCTM(context, -cropRect.origin.x, -cropRect.origin.y);
//            [self drawAtPoint:drawPoint];
            CGContextScaleCTM(context, 1, -1);
            CGContextTranslateCTM(context, 0, -self.size.height);
            CGContextTranslateCTM(context, -cropRect.origin.x, cropRect.origin.y);
            CGContextDrawImage(context, CGRectMake(drawPoint.x, drawPoint.y, self.size.width, self.size.height), self.CGImage);
        }
    
    croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
   
    return croppedImage;
}



@end

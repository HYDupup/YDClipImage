//
//  CropViewController.h
//  poco_CropImage
//
//  Created by mac on 17/7/26.
//  Copyright © 2017年 HYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CropViewControllerDelegate <NSObject>

@optional
-(void)backCropImage:(UIImage *)cropImgae;

@end

@interface CropViewController : UIViewController

-(instancetype)initWithImage:(UIImage *)initialImage;

/*
 原始图片
 */
@property (nonatomic,strong)UIImage *initialImage;

@property (nonatomic,weak)id<CropViewControllerDelegate>delegate;

@end
